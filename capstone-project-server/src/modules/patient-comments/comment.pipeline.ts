import { Injectable } from '@nestjs/common';
import { PipelineStage } from 'mongoose';
import { MongoCollection } from 'src/constants/mongo-collection-constant';
import { ToObjectId } from 'src/utils/mongo-helper';

type TCommentParam = {
  commentId?: any;
  postId?: any;
  parentId?: any;
};

@Injectable()
export class CommentPipeline {
  lookupPatientPipeline: Array<
    PipelineStage.Lookup | PipelineStage.Project | PipelineStage.AddFields
  > = [
    {
      $lookup: {
        from: MongoCollection.Patients,
        localField: 'patient',
        foreignField: '_id',
        as: 'patient',
      },
    },
    {
      $addFields: {
        patient: {
          $first: '$patient',
        },
      },
    },
    {
      $project: {
        patient: {
          phone_number: 0,
          gender: 0,
          posts: 0,
          roles: 0,
          is_deleted: 0,
          is_banned: 0,
          createdAt: 0,
          updatedAt: 0,
          email: 0,
          __v: 0,
        },
      },
    },
  ];

  lookupRepliesPipeline = (
    startWith: any,
    includeDeleted?: boolean,
  ): Array<PipelineStage.GraphLookup> => {
    if (includeDeleted) {
      return [
        {
          $graphLookup: {
            from: MongoCollection.PatientComments,
            startWith:
              startWith === '$$ROOT._id' ? '$$ROOT._id' : ToObjectId(startWith),
            connectFromField: '_id',
            connectToField: 'parent',
            as: 'replies',
          },
        },
      ];
    }
    return [
      {
        $graphLookup: {
          from: MongoCollection.PatientComments,
          startWith:
            startWith === '$$ROOT._id' ? '$$ROOT._id' : ToObjectId(startWith),
          connectFromField: '_id',
          connectToField: 'parent',
          as: 'replies',
          restrictSearchWithMatch: {
            is_deleted: false,
          },
        },
      },
    ];
  };

  lookupParentPipeline: Array<
    PipelineStage.Lookup | PipelineStage.AddFields | PipelineStage.Project
  > = [
    {
      $lookup: {
        from: MongoCollection.PatientComments,
        localField: 'parent',
        foreignField: '_id',
        as: 'parent',
        pipeline: [
          {
            $match: {
              is_deleted: false,
            },
          },
          ...this.lookupPatientPipeline,
          {
            $addFields: {
              reply_count: { $size: '$children' },
            },
          },
        ],
      },
    },
    {
      $addFields: {
        parent: {
          $first: '$parent',
        },
      },
    },
    {
      $addFields: {
        parent: {
          $ifNull: ['$parent', null],
        },
      },
    },
  ];

  lookupChildrenPipeline: Array<PipelineStage> = [
    {
      $match: {
        is_deleted: false,
      },
    },
    {
      $lookup: {
        from: MongoCollection.PatientComments,
        localField: '_id',
        foreignField: 'parent',
        as: 'children',
        pipeline: [
          {
            $match: {
              is_deleted: false,
            },
          },
          ...this.lookupRepliesPipeline('$$ROOT._id'),
          // ...this.lookupParentPipeline,
          ...this.lookupPatientPipeline,
          {
            $addFields: {
              reply_count: { $size: '$replies' },
            },
          },
          {
            $project: {
              replies: 0,
            },
          },
        ],
      },
    },
  ];

  repliesPipeline({
    commentId,
    postId,
    includeDeleted,
  }: TCommentParam & { includeDeleted?: boolean }): PipelineStage[] {
    return [
      !includeDeleted
        ? {
            $match: {
              is_deleted: false,
            },
          }
        : {
            $match: {},
          },
      commentId
        ? {
            $match: {
              _id: ToObjectId(commentId),
            },
          }
        : { $match: {} },
      postId
        ? {
            $match: {
              post: ToObjectId(postId),
            },
          }
        : { $match: {} },
      ...this.lookupRepliesPipeline(commentId ?? '$$ROOT._id', includeDeleted),
      ...this.lookupPatientPipeline,
      ...this.lookupParentPipeline,
      ...this.lookupChildrenPipeline,
      {
        $addFields: {
          reply_count: { $size: '$replies' },
        },
      },
    ];
  }

  allCommentPipeline(): PipelineStage[] {
    return [
      ...this.repliesPipeline({}),
      {
        $sort: {
          createdAt: 1,
        },
      },
      {
        $project: {
          replies: 0,
        },
      },
    ];
  }

  oneCommentByIdPipeline({ commentId }: TCommentParam): PipelineStage[] {
    return [
      ...this.repliesPipeline({ commentId }),
      {
        $sort: {
          createdAt: 1,
        },
      },
      {
        $project: {
          replies: 0,
        },
      },
    ];
  }

  commentByPostPipeline({ postId, parentId }: TCommentParam): PipelineStage[] {
    return [
      {
        $match: {
          is_deleted: false,
          parent: ToObjectId(parentId) ?? null,
        },
      },
      postId
        ? {
            $match: {
              post: ToObjectId(postId),
            },
          }
        : { $match: {} },
      {
        $sort: {
          createdAt: 1,
        },
      },
      ...this.lookupRepliesPipeline('$$ROOT._id'),
      ...this.lookupPatientPipeline,
      ...this.lookupChildrenPipeline,
      {
        $addFields: {
          reply_count: { $size: '$replies' },
        },
      },
      {
        $project: {
          replies: 0,
        },
      },
    ];
  }
}
