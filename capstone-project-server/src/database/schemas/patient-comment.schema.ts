import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument } from 'mongoose';
import { MODEL } from 'src/constants/model-constant';
import { TObjectId } from 'src/utils/mongo-helper';
import { Patient } from './patient.schema';
import { Post } from './post.schema';

export type PatientCommentDocument = HydratedDocument<PatientComment>;

@Schema({ timestamps: true })
export class PatientComment {
  @Prop({ type: String, minlength: 1, trim: true })
  content: string;

  @Prop({ type: TObjectId, ref: MODEL.Patient })
  patient: Patient;

  @Prop({ type: TObjectId, ref: MODEL.Post })
  post: Post;

  @Prop({
    type: TObjectId,
    ref: MODEL.PatientComment,
    default: null,
    isRequired: false,
  })
  parent: Comment;

  @Prop({
    type: [{ type: TObjectId, ref: MODEL.PatientComment }],
    default: [],
    isRequired: false,
  })
  children: Array<Comment>;

  @Prop({ type: Boolean, default: false })
  is_deleted: boolean;
}

export const PatientCommentSchema =
  SchemaFactory.createForClass(PatientComment);

