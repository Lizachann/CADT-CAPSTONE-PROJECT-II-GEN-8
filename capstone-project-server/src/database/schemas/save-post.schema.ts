import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument } from 'mongoose';
import { Patient } from './patient.schema';
import { Post } from './post.schema';
import { MODEL } from 'src/constants/model-constant';
import { TObjectId } from 'src/utils/mongo-helper';

export type SavePostsDocument = HydratedDocument<SavePost>;

@Schema({ timestamps: true })
export class SavePost {
  @Prop({ type: TObjectId, ref: MODEL.Patient, isRequired: true })
  patient: Patient;

  @Prop({ type: TObjectId, ref: MODEL.Post, isRequired: true })
  post: Post;

  @Prop({ type: Boolean, default: true })
  is_saved: boolean;
}

export const SavedPostSchema = SchemaFactory.createForClass(SavePost);
