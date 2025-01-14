import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument } from 'mongoose';
import { MODEL } from 'src/constants/model-constant';
import { TObjectId } from 'src/utils/mongo-helper';
import { ActivityImages } from './activity-image.schema';

export type ActivityDocument = HydratedDocument<Activity>;

@Schema({ timestamps: true })
export class Activity {
  @Prop({ required: true })
  title: string;

  @Prop()
  description: string;

  @Prop()
  type: string;

  @Prop()
  fitness?: string;

  @Prop()
  mentalHealth?: string;

  @Prop()
  socialSkill?: string;

  @Prop()
  development?: string;

  @Prop()
  stresslvl?: number;

  @Prop({ type: [{ type: TObjectId, ref: MODEL.ActivityImages }] })
  activityImages: ActivityImages[];
}

export const ActivitySchema = SchemaFactory.createForClass(Activity);
