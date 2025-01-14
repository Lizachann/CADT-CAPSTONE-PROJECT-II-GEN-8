import { Module } from '@nestjs/common';
import { PostPhotosService } from './post-photos.service';
import { PostPhotosController } from './post-photos.controller';
import { MongooseModule } from '@nestjs/mongoose';
import {
  PostPhoto,
  PostPhotoSchema,
} from 'src/database/schemas/post-photo-schema';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: PostPhoto.name, schema: PostPhotoSchema },
    ]),
  ],
  controllers: [PostPhotosController],
  providers: [PostPhotosService],
})
export class PostPhotosModule {}
