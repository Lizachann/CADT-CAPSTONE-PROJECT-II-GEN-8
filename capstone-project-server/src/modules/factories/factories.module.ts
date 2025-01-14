import { Module } from '@nestjs/common';
import { FactoriesService } from './factories.service';
import { FactoriesController } from './factories.controller';
import { MongooseModule } from '@nestjs/mongoose';
import { Patient, PatientSchema } from 'src/database/schemas/patient.schema';
import { Post, PostSchema } from 'src/database/schemas/post.schema';
import { Therapist, TherapistSchema } from 'src/database/schemas/therapist.schema';
import { Appointment, AppointmentSchema } from 'src/database/schemas/appointment.schema';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: Patient.name, schema: PatientSchema },
      { name: Post.name, schema: PostSchema },
      { name: Therapist.name, schema: TherapistSchema },
      { name: Appointment.name, schema: AppointmentSchema },
    ]),
  ],
  controllers: [FactoriesController],
  providers: [FactoriesService],
})
export class FactoriesModule {}
