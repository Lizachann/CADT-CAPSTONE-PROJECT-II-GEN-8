import { faker } from '@faker-js/faker';
import { CreatePostDto } from 'src/modules/posts/dto/create-post.dto';
import { stringToHex } from 'src/utils/seeder-helpter';

export const PostFactory = ({ length }: { length?: number }) => {
  const list: Array<CreatePostDto & { _id: string }> = [];
  Array.from({ length: length ?? 10 }).forEach((_, index) => {
    list.push({
      _id: stringToHex(`adminpost${index}`),
      body: faker.lorem.sentence(5),
      patient: stringToHex(`admin`),
    });
  });

  return list;
};
