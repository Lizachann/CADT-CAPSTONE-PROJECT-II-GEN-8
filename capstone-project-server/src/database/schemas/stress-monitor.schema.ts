import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument } from 'mongoose';
import { MODEL } from 'src/constants/model-constant';
import { TObjectId } from 'src/utils/mongo-helper';
import { Patient } from './patient.schema';

export type StressMonitorDocument = HydratedDocument<StressMonitor>;

@Schema({ timestamps: true })
export class StressMonitor {
  @Prop({ type: Number, isRequired: true, default: 0 })
  total_score: number;

  @Prop({ type: TObjectId, ref: MODEL.Patient })
  patient: Patient;
}

export const StressMonitorSchema = SchemaFactory.createForClass(StressMonitor);
