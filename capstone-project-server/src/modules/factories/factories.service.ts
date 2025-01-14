import { Injectable } from '@nestjs/common';
import { CreateFactoryDto } from './dto/create-factory.dto';
import { InjectModel } from '@nestjs/mongoose';
import { Patient } from 'src/database/schemas/patient.schema';
import { Model } from 'mongoose';
import { Post } from 'src/database/schemas/post.schema';
import { seed } from 'src/utils/seeder-helpter';
import { Therapist } from 'src/database/schemas/therapist.schema';
import { TherapistFactory } from 'src/database/factories/therapists.factory';
import { Appointment } from 'src/database/schemas/appointment.schema';

@Injectable()
export class FactoriesService {
  constructor(
    @InjectModel(Patient.name) private patientsModel: Model<Patient>,
    @InjectModel(Post.name) private postsModel: Model<Post>,
    @InjectModel(Therapist.name) private therapistModel: Model<Therapist>,
    @InjectModel(Appointment.name) private appointmentModel: Model<Appointment>,
  ) {}

  async create(createFactoryDto: CreateFactoryDto) {
    // await seed({
    //   model: this.patientsModel,
    //   seedData: PatientFactory({ ...createFactoryDto }),
    // });

    // await seed({
    //   model: this.patientsModel,
    //   seedData: PatientSeeder(),
    // });

    // await seed({
    //   model: this.postsModel,
    //   seedData: PostFactory({ ...createFactoryDto }),
    // });

    await seed({
      model: this.therapistModel,
      seedData: TherapistFactory({ ...createFactoryDto }),
    });

    // await seed({
    //   model: this.appointmentModel,
    //   seedData: AppointmentFactory(
    //     { ...createFactoryDto },
    //     this.therapistModel,
    //     this.patientsModel,
    //   ),
    // });

    // Other factory

    return {
      message: 'Finish running factory',
    };
  }
}
