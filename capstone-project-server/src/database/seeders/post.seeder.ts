import { CreatePostDto } from 'src/modules/posts/dto/create-post.dto';
import { stringToHex, TSeederNames } from 'src/utils/seeder-helpter';

export const PostSeeder = () => {
  const createPosts = ({
    index,
    name,
    body,
  }: {
    index: number;
    name: TSeederNames;
    body: string;
  }) => {
    const post: CreatePostDto & { _id: string; comment_count: number } = {
      _id: stringToHex(`${name}post${index}`),
      body: `(${name}) - ${body}`,
      patient: stringToHex(name),
      comment_count: index === 1 ? 8 : index === 2 ? 4 : 0,
    };

    return post;
  };

  const postSeeds = [
    createPosts({ index: 1, name: 'chhay', body: 'Post with comments' }),
    createPosts({ index: 2, name: 'rpong', body: 'Post with comments' }),
    createPosts({ index: 3, name: 'panha', body: 'Post with comments' }),
    createPosts({ index: 4, name: 'vchit', body: 'Post with comments' }),
    createPosts({ index: 5, name: 'lizaj', body: 'Post with comments' }),
    createPosts({ index: 6, name: 'lizac', body: 'Post with comments' }),
  ];

  return postSeeds;
};
