import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument } from 'mongoose';
import { Activity } from './activity.schema';
import { TObjectId } from 'src/utils/mongo-helper';
import { MODEL } from 'src/constants/model-constant';

export type ActivityImagesDocument = HydratedDocument<ActivityImages>;

@Schema({ timestamps: true })
export class ActivityImages {
  @Prop({ type: String })
  filename: string;

  @Prop({ type: TObjectId, ref: MODEL.Activities })
  activity: Activity;
}

export const ActivityImagesSchema =
  SchemaFactory.createForClass(ActivityImages);
