import { Injectable } from '@nestjs/common';
import { UpdatePostPhotoDto } from './dto/update-post-photo.dto';
import { InjectModel } from '@nestjs/mongoose';
import { PostPhoto } from 'src/database/schemas/post-photo-schema';
import { Model } from 'mongoose';
import { CreatePostPhotoDto } from './dto/create-post-photo.dto';

@Injectable()
export class PostPhotosService {
  constructor(
    @InjectModel(PostPhoto.name) private postPhoto: Model<PostPhoto>,
  ) {}

  async create(id: any, files: Array<Express.Multer.File>) {
    const postPhotos: Array<CreatePostPhotoDto> = [];

    files.forEach((file) => {
      postPhotos.push({
        filename: file.filename,
        post: id,
      });
    });

    await this.postPhoto.insertMany(postPhotos);
    const resId = await this.postPhoto.find({ post: id }).select('_id');
    return resId;
  }

  async findAll() {
    const res = await this.postPhoto.find().populate(['post']);
    return res;
  }

  findOne(id: number) {
    return `This action returns a #${id} postPhoto`;
  }

  update(id: number, updatePostPhotoDto: UpdatePostPhotoDto) {
    return `This action updates a #${id} postPhoto`;
  }

  remove(id: number) {
    return `This action removes a #${id} postPhoto`;
  }
}
