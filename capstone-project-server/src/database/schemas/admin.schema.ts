import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument } from 'mongoose';
import { ROLES } from 'src/constants/roles-constant';
import { TObjectId } from 'src/utils/mongo-helper';
import { MODEL } from 'src/constants/model-constant';
import { Credential } from './credential.schema';

export type AdminDocument = HydratedDocument<Admin>;

@Schema({ timestamps: true })
export class Admin {
  @Prop({ type: String, isRequired: true })
  username: string;

  @Prop({ type: String, isRequired: false })
  profile_img: string;

  @Prop({ isRequired: false })
  refresh_token: string;

  @Prop({ type: TObjectId, ref: MODEL.Credential })
  credential: Credential;

  @Prop({ type: Array, enum: ROLES, default: [ROLES.ADMIN] })
  roles: ROLES;
}

export const AdminSchema = SchemaFactory.createForClass(Admin);
