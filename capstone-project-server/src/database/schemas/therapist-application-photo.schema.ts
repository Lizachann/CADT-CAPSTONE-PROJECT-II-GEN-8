import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument } from 'mongoose';
import { MODEL } from 'src/constants/model-constant';
import { TObjectId } from 'src/utils/mongo-helper';
import { TherapistApplication } from './therapist-application.schema';

export type TherapistApplicationPhotoDocument =
  HydratedDocument<TherapistApplicationPhoto>;

@Schema({ timestamps: true })
export class TherapistApplicationPhoto {
  @Prop({ type: String })
  filename: string;

  @Prop({ type: TObjectId, ref: MODEL.TherapistApplication })
  therapist_application: TherapistApplication;
}

export const TherapistApplicationPhotoSchema = SchemaFactory.createForClass(
  TherapistApplicationPhoto,
);
