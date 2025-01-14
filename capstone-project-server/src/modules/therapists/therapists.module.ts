import { Module } from '@nestjs/common';
import { TherapistsService } from './therapists.service';
import { TherapistsController } from './therapists.controller';
import { MongooseModule } from '@nestjs/mongoose';
import {
  Therapist,
  TherapistSchema,
} from 'src/database/schemas/therapist.schema';
import {
  TherapistApplication,
  TherapistApplicationSchema,
} from 'src/database/schemas/therapist-application.schema';
import { TherapistApplicationPhotosService } from '../therapist-application-photos/therapist-application-photos.service';
import {
  TherapistApplicationPhoto,
  TherapistApplicationPhotoSchema,
} from 'src/database/schemas/therapist-application-photo.schema';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: Therapist.name, schema: TherapistSchema },
      { name: TherapistApplication.name, schema: TherapistApplicationSchema },
      {
        name: TherapistApplicationPhoto.name,
        schema: TherapistApplicationPhotoSchema,
      },
    ]),
  ],
  controllers: [TherapistsController],
  providers: [TherapistsService, TherapistApplicationPhotosService],
})
export class TherapistsModule {}
