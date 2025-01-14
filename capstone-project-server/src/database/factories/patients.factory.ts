import { faker } from '@faker-js/faker';
import { GENDER } from 'src/constants/gender-constant';
import { CreatePatientDto } from 'src/modules/patients/dto/create-patient.dto';
import { stringToHex } from 'src/utils/seeder-helpter';
import data from 'public/data/static-img.json';

export const PatientFactory = ({ length }: { length?: number }) => {
  const fakePatient: CreatePatientDto[] = [];
  Array.from({ length: length ?? 10 }).forEach((i) => {
    fakePatient.push({
      credential: stringToHex(`${faker.internet.userName()}cred${i}`),
      username: faker.internet.userName(),
      // phone_number: '+855' + faker.string.numeric(8),
      gender: GENDER.MALE,
      credits: 0,
      profile_img: data.profileImg.one,
    });
  });

  return [...fakePatient];
};
