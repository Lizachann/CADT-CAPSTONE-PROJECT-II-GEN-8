import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument } from 'mongoose';
import { GENDER } from 'src/constants/gender-constant';
import { MODEL } from 'src/constants/model-constant';
import { ROLES } from 'src/constants/roles-constant';
import { TObjectId } from 'src/utils/mongo-helper';

export type TherapistDocument = HydratedDocument<Therapist>;

@Schema({ timestamps: true })
export class Therapist {
  @Prop({ type: String, minlength: 2, maxlength: 64 })
  first_name: string;

  @Prop({ type: String, minlength: 2, maxlength: 64 })
  last_name: string;

  @Prop({ type: String })
  bio: string;

  @Prop({
    type: String,
    minlength: 2,
    maxlength: 64,
    unique: true,
  })
  username: string;

  @Prop({ type: String, unique: true })
  email: string;

  @Prop({ isRequired: false })
  refresh_token: string;

  @Prop({ type: TObjectId, ref: MODEL.Credential })
  credential: Credential;

  @Prop({ type: String, unique: true, trim: true })
  phone_number: string;

  @Prop({ type: Number })
  hourly_rate: number;

  @Prop({ type: String, enum: GENDER, isRequired: false })
  gender: GENDER;

  @Prop({ type: Array, isRequired: false, default: [] })
  specializations: string[];

  @Prop({ type: Array, enum: ROLES, default: [ROLES.THERAPIST] })
  roles: ROLES;

  @Prop({ default: false })
  is_deleted: boolean;
}

export const TherapistSchema = SchemaFactory.createForClass(Therapist);
