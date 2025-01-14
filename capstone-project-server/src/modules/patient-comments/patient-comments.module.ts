import { Module } from '@nestjs/common';
import { PatientCommentsService } from './patient-comments.service';
import { PatientCommentsController } from './patient-comments.controller';
import { MongooseModule } from '@nestjs/mongoose';
import {
  PatientCommentSchema,
  PatientComment,
} from 'src/database/schemas/patient-comment.schema';
import { Patient, PatientSchema } from 'src/database/schemas/patient.schema';
import { Post, PostSchema } from 'src/database/schemas/post.schema';
import { CommentPipeline } from './comment.pipeline';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: PatientComment.name, schema: PatientCommentSchema },
      { name: Patient.name, schema: PatientSchema },
      { name: Post.name, schema: PostSchema },
    ]),
  ],
  controllers: [PatientCommentsController],
  providers: [PatientCommentsService, CommentPipeline],
})
export class PatientCommentsModule {}
