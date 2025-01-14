import { Module } from '@nestjs/common';
import { PostPhotosService } from '../post-photos/post-photos.service';
import { PostsService } from './posts.service';
import { PostsController } from './posts.controller';
import { MongooseModule } from '@nestjs/mongoose';
import { Post, PostSchema } from 'src/database/schemas/post.schema';
import { Patient, PatientSchema } from 'src/database/schemas/patient.schema';
import {
  PostPhoto,
  PostPhotoSchema,
} from 'src/database/schemas/post-photo-schema';
import {
  PatientComment,
  PatientCommentSchema,
} from 'src/database/schemas/patient-comment.schema';
import { HttpModule } from '@nestjs/axios';

@Module({
  imports: [
    HttpModule,
    MongooseModule.forFeature([
      { name: Post.name, schema: PostSchema },
      { name: Patient.name, schema: PatientSchema },
      { name: PatientComment.name, schema: PatientCommentSchema },
      { name: PostPhoto.name, schema: PostPhotoSchema },
    ]),
  ],
  controllers: [PostsController],
  providers: [PostsService, PostPhotosService],
})
export class PostsModule {}
