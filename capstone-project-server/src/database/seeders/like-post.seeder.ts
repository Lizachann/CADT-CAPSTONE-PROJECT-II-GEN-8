import { UpdateLikePostDto } from 'src/modules/like-posts/dto/update-like-post.dto';
import { stringToHex, TSeederNames } from 'src/utils/seeder-helpter';

export const LikePostSeeder = () => {
  const createLikes = (name: TSeederNames) => {
    const names: TSeederNames[] = [
      'chhay',
      'lizac',
      'lizaj',
      'rpong',
      'panha',
      'vchit',
    ];
    const list: Array<UpdateLikePostDto> = [];

    names.forEach((val, index) => {
      if (val !== name && name) {
        list.push({
          patient: stringToHex(name),
          post: stringToHex(`${name}post${index}`),
        });
      }
    });

    return list;
  };

  const postSeeds = [
    ...createLikes('chhay'),
    ...createLikes('rpong'),
    ...createLikes('panha'),
    ...createLikes('vchit'),
    ...createLikes('lizaj'),
    ...createLikes('lizac'),
  ];

  return postSeeds;
};
