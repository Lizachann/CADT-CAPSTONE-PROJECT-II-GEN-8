import { Module } from '@nestjs/common';
import { SavedPostsService as SavePostsService } from './save-posts.service';
import { SavedPostsController as SavePostsController } from './save-posts.controller';
import { MongooseModule } from '@nestjs/mongoose';
import {
  SavePost,
  SavedPostSchema,
} from 'src/database/schemas/save-post.schema';
import { Post, PostSchema } from 'src/database/schemas/post.schema';
import { Patient, PatientSchema } from 'src/database/schemas/patient.schema';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: SavePost.name, schema: SavedPostSchema },
      { name: Post.name, schema: PostSchema },
      { name: Patient.name, schema: PatientSchema },
    ]),
  ],
  controllers: [SavePostsController],
  providers: [SavePostsService],
})
export class SavePostsModule {}
