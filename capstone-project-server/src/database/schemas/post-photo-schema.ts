import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument } from 'mongoose';
import { MODEL } from 'src/constants/model-constant';
import { TObjectId } from 'src/utils/mongo-helper';
import { Post } from './post.schema';

export type PostPhotoDocument = HydratedDocument<PostPhoto>;

@Schema({ timestamps: true })
export class PostPhoto {
  @Prop({ type: String })
  filename: string;

  @Prop({ type: TObjectId, ref: MODEL.Post})
  post: Post;
}

export const PostPhotoSchema = SchemaFactory.createForClass(PostPhoto);
