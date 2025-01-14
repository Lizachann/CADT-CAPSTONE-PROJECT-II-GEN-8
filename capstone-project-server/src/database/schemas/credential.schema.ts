import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument } from 'mongoose';

export type CredentialDocument = HydratedDocument<Credential>;

@Schema({ timestamps: true })
export class Credential {
  @Prop({ unique: true })
  email: string;

  @Prop()
  password: string;
}

export const CredentialSchema = SchemaFactory.createForClass(Credential);
