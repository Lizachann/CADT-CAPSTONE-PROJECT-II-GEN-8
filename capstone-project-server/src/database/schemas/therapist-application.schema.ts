import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument } from 'mongoose';
import { MODEL } from 'src/constants/model-constant';
import { TObjectId } from 'src/utils/mongo-helper';
import { TherapistApplicationPhoto } from './therapist-application-photo.schema';
import { THERAPIST_APPLICATION_STATUS } from 'src/constants/therapist-application-constant';

export type TherapistApplicationDocument =
  HydratedDocument<TherapistApplication>;

@Schema({ timestamps: true })
export class TherapistApplication {
  @Prop({ type: String, minlength: 2, maxlength: 64 })
  first_name: string;

  @Prop({ type: String, minlength: 2, maxlength: 64 })
  last_name: string;

  @Prop({ type: String, unique: true })
  email: string;

  @Prop({
    type: String,
    enum: THERAPIST_APPLICATION_STATUS,
    default: THERAPIST_APPLICATION_STATUS.REQUESTED,
  })
  status: THERAPIST_APPLICATION_STATUS;

  @Prop({ type: [{ type: TObjectId, ref: MODEL.TherapistApplicationPhoto }] })
  therapistApplicationPhotos: TherapistApplicationPhoto[];
}

export const TherapistApplicationSchema =
  SchemaFactory.createForClass(TherapistApplication);
