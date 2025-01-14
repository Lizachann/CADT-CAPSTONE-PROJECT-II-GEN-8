import { CreateAdminDto } from 'src/modules/admins/dto/create-admin.dto';
import { getRandomImage } from 'src/utils/helpter';
import { stringToHex, TSeederNames } from 'src/utils/seeder-helpter';

type TAdminSeed = {
  name: TSeederNames;
  index: number;
};

export const AdminSeeder = () => {
  const createAdmin = ({ name, index }: TAdminSeed) => {
    const admin: CreateAdminDto & { _id: string } = {
      username: name,
      _id: stringToHex(`${name}admin${index}`),
      profile_img: getRandomImage(),
      email: `${name}@chhantek.com`,
      password: `P@$$w0rd`,
    };

    return admin;
  };

  const adminSeeds = [
    createAdmin({
      name: 'chhay',
      index: 1,
    }),
    createAdmin({
      name: 'rpong',
      index: 2,
    }),
    createAdmin({
      name: 'panha',
      index: 3,
    }),
    createAdmin({
      name: 'vchit',
      index: 4,
    }),
    createAdmin({
      name: 'lizac',
      index: 5,
    }),
    createAdmin({
      name: 'lizaj',
      index: 6,
    }),
  ];

  return adminSeeds;
};
