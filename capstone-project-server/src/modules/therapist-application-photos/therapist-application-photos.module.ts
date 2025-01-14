import { Module } from '@nestjs/common';
import { TherapistApplicationPhotosService } from './therapist-application-photos.service';
import { TherapistApplicationPhotosController } from './therapist-application-photos.controller';
import { MongooseModule } from '@nestjs/mongoose';
import {
  TherapistApplicationPhoto,
  TherapistApplicationPhotoSchema,
} from 'src/database/schemas/therapist-application-photo.schema';

@Module({
  imports: [
    MongooseModule.forFeature([
      {
        name: TherapistApplicationPhoto.name,
        schema: TherapistApplicationPhotoSchema,
      },
    ]),
  ],
  controllers: [TherapistApplicationPhotosController],
  providers: [TherapistApplicationPhotosService],
})
export class TherapistApplicationPhotosModule {}
