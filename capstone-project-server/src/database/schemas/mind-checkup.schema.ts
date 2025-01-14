import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument } from 'mongoose';
import { MODEL } from 'src/constants/model-constant';
import { TObjectId } from 'src/utils/mongo-helper';
import { Patient } from './patient.schema';

export type MindCheckupDocument = HydratedDocument<MindCheckup>;

@Schema({ timestamps: true })
export class MindCheckup {
  @Prop({ type: String })
  result: string;

  @Prop({ type: TObjectId, ref: MODEL.Patient })
  patient: Patient;
}

export const MindCheckupSchema = SchemaFactory.createForClass(MindCheckup);
