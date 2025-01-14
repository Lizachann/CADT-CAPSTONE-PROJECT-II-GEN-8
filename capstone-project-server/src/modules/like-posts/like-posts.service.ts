import { Injectable, NotFoundException } from '@nestjs/common';
import { UpdateLikePostDto } from './dto/update-like-post.dto';
import { InjectModel } from '@nestjs/mongoose';
import { LikePost } from 'src/database/schemas/like-post.schema';
import { Model } from 'mongoose';
import { CreateLikePostDto } from './dto/create-like-post.dto';
import { Post } from 'src/database/schemas/post.schema';
import { PaginationParamDto } from 'src/common/dto/pagination-param.dto';
import { MODEL } from 'src/constants/model-constant';
import { Patient } from 'src/database/schemas/patient.schema';

@Injectable()
export class LikePostsService {
  constructor(
    @InjectModel(LikePost.name) private likePostModel: Model<LikePost>,
    @InjectModel(Post.name) private postModel: Model<Post>,
    @InjectModel(Patient.name) private patientModel: Model<Patient>,
  ) {}

  async create(createLikePostDto: CreateLikePostDto) {
    const res = await this.likePostModel.create(createLikePostDto);
    return res;
  }

  async findAll(pagination: PaginationParamDto) {
    const { limit = 10, page = 1 } = pagination;
    const skip = limit * page - limit;

    const res = await this.likePostModel
      .find()
      .populate(['patient'])
      .skip(skip)
      .limit(limit);

    return res;
  }

  async findLikePostByPost(id: string) {
    const res = await this.likePostModel
      .find({ post: id, is_like: true })
      .populate(['patient']);

    if (!res) return [];

    return res;
  }

  async findLikePostByPatient(id: string) {
    const res = await this.likePostModel
      .find({ patient: id, is_like: true })
      .populate({
        path: 'post',
        populate: {
          path: 'patient',
          model: MODEL.Patient,
        },
      });

    if (!res) return [];

    return res;
  }

  private async findPostLikeCount(postId: string) {
    const likeCount = await this.likePostModel
      .find({
        post: postId,
        is_like: true,
      })
      .countDocuments();

    return likeCount;
  }

  private async updatePostLikeCount(postId: string) {
    const likeCount = await this.findPostLikeCount(postId);

    await this.postModel.findOneAndUpdate(
      {
        _id: postId,
      },
      {
        $set: {
          like_count: likeCount,
        },
      },
    );

    return likeCount;
  }

  async update(id: string, updateLikePostDto: UpdateLikePostDto) {
    const findPost = await this.postModel.findOne({ _id: id });
    if (!findPost) throw new NotFoundException(`Post ${id} does not exist`);

    const findPatient = await this.patientModel.findOne({
      _id: updateLikePostDto.patient,
    });
    if (!findPatient)
      throw new NotFoundException(`Patient ${id} does not exist`);

    // find like post record
    const findLikePost = await this.likePostModel.findOne({
      patient: updateLikePostDto.patient,
      post: id,
    });

    // if not exist
    if (!findLikePost) {
      const res = await this.likePostModel.create({
        patient: updateLikePostDto.patient,
        post: id,
      });

      // update like count of post
      await this.updatePostLikeCount(id);

      return {
        message: 'Like',
        data: res,
      };
    }

    // if exist and is like
    if (findLikePost.is_like) {
      const res = await findLikePost.updateOne({
        is_like: false,
      });

      // update like count of original post
      await this.updatePostLikeCount(id);

      return {
        message: 'Unlike',
        data: res,
      };
    }

    const res = await findLikePost.updateOne({
      is_like: true,
    });
    // update like count of original post
    await this.updatePostLikeCount(id);

    return {
      message: 'Like',
      data: res,
    };
  }
}
