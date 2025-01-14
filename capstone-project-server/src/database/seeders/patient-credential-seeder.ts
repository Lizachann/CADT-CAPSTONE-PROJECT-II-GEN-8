import { GENDER } from 'src/constants/gender-constant';
import { RegisterDto } from 'src/modules/auth/dto/register.dto';
import { getRandomImage } from 'src/utils/helpter';
import { stringToHex, TSeederNames } from 'src/utils/seeder-helpter';

type TAdminSeed = {
  name: TSeederNames;
  index: number;
};

type TPatientSeed = {
  name: TSeederNames;
  index: number;
};

export const PatientCredSeeder = () => {
  const createPosts = ({ name, index }: TPatientSeed) => {
    return stringToHex(`${name}post${index}`);
  };
  
  const createPatientCred = ({ name, index }: TAdminSeed) => {
    const patientCred: RegisterDto & { _id: string; posts: Array<string>; } = {
      _id: stringToHex(name),
      email: `${name}@gmail.com`,
      password: `P@$$w0rd`,
      credential: stringToHex(`${name}cred${index}`),
      credits: 0,
      gender:
        name !== 'lizac' && name !== 'lizaj' ? GENDER.MALE : GENDER.FEMALE,
      // phone_number: '+855' + faker.string.numeric(8),
      username: name,
      posts: [
        createPosts({
          name,
          index,
        }),
      ],
      profile_img: getRandomImage(),
    };

    return patientCred;
  };

  const patientCredSeeds = [
    createPatientCred({
      name: 'chhay',
      index: 1,
    }),
    createPatientCred({
      name: 'rpong',
      index: 2,
    }),
    createPatientCred({
      name: 'panha',
      index: 3,
    }),
    createPatientCred({
      name: 'vchit',
      index: 4,
    }),
    createPatientCred({
      name: 'lizac',
      index: 5,
    }),
    createPatientCred({
      name: 'lizaj',
      index: 6,
    }),

  ];

  return patientCredSeeds;
};
