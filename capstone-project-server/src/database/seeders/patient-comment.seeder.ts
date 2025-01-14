import { CreatePatientCommentDto } from 'src/modules/patient-comments/dto/create-patient-comment.dto';
import { stringToHex, TSeederNames } from 'src/utils/seeder-helpter';

type TPost = {
  index: number;
  name: TSeederNames;
};

type TPatientComment = {
  name: TSeederNames;
  content: string;
  index: number;
  post: TPost;
  children?: Array<number>;
};

type TChildComment = TPatientComment & {
  parent: number;
};

export const PatientCommentSeeder = () => {
  const createPosts = ({ name, index }: TPost) => {
    return stringToHex(`${name}post${index}`);
  };

  const createChildId = (name: TSeederNames, children: Array<number>) => {
    const allChildren = [];
    children?.forEach((child) => {
      allChildren.push(stringToHex(`${name}cmt${child}`));
    });

    return allChildren;
  };

  const createComment = ({
    name,
    content,
    index,
    children,
    post,
  }: TPatientComment) => {
    const comment: CreatePatientCommentDto & { _id: string } = {
      _id: stringToHex(`${name}cmt${index}`),
      content: content,
      post: createPosts(post),
      patient: stringToHex(name),
      children: createChildId(name, children),
    };
    return comment;
  };

  const createChildComment = ({
    name,
    content,
    index,
    children,
    parent,
    post,
  }: TChildComment) => {
    const comment: CreatePatientCommentDto & { _id: string } = {
      _id: stringToHex(`${name}cmt${index}`),
      content: content,
      post: createPosts(post),
      patient: stringToHex(name),
      parent: stringToHex(`${name}cmt${parent}`),
      children: createChildId(name, children),
    };
    return comment;
  };

  const firstCommentBatch = [
    createComment({
      index: 1,
      name: 'chhay',
      content: 'First comment',
      children: [11],
      post: {
        name: 'chhay',
        index: 1,
      },
    }),
    createChildComment({
      index: 11,
      name: 'chhay',
      content: 'First reply',
      parent: 1,
      children: [12],
      post: {
        name: 'chhay',
        index: 1,
      },
    }),
    createChildComment({
      index: 14,
      name: 'chhay',
      content: 'First Second reply',
      parent: 1,
      post: {
        name: 'chhay',
        index: 1,
      },
    }),
    createChildComment({
      index: 12,
      name: 'chhay',
      content: 'First nested reply',
      parent: 11,
      children: [13],
      post: {
        name: 'chhay',
        index: 1,
      },
    }),
    createChildComment({
      index: 13,
      name: 'chhay',
      content: 'First nested nested reply',
      parent: 12,
      post: {
        name: 'chhay',
        index: 1,
      },
    }),
  ];

  const secondCommentBatch = [
    createComment({
      index: 2,
      name: 'chhay',
      content: 'Second comment',
      children: [21],
      post: {
        name: 'chhay',
        index: 1,
      },
    }),
    createChildComment({
      index: 21,
      name: 'chhay',
      content: 'Second reply',
      parent: 2,
      children: [22],
      post: {
        name: 'chhay',
        index: 1,
      },
    }),
    createChildComment({
      index: 22,
      name: 'chhay',
      content: 'Second nested reply',
      parent: 21,
      children: [23],
      post: {
        name: 'chhay',
        index: 1,
      },
    }),
    createChildComment({
      index: 23,
      name: 'chhay',
      content: 'Second nested nested reply',
      parent: 22,
      post: {
        name: 'chhay',
        index: 1,
      },
    }),
  ];

  const thirdCommentBatch = [
    createComment({
      index: 3,
      name: 'chhay',
      content: 'Third comment',
      children: [31],
      post: {
        name: 'rpong',
        index: 2,
      },
    }),
    createChildComment({
      index: 31,
      name: 'chhay',
      content: 'Third reply',
      parent: 3,
      children: [32],
      post: {
        name: 'rpong',
        index: 2,
      },
    }),
    createChildComment({
      index: 32,
      name: 'chhay',
      content: 'Third nested reply',
      parent: 31,
      children: [33],
      post: {
        name: 'rpong',
        index: 2,
      },
    }),
    createChildComment({
      index: 33,
      name: 'chhay',
      content: 'Third nested nested reply',
      parent: 32,
      post: {
        name: 'rpong',
        index: 2,
      },
    }),
  ];

  const commentSeeds = [
    ...firstCommentBatch,
    ...secondCommentBatch,
    ...thirdCommentBatch,
  ];

  return commentSeeds;
};
