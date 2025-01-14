import { Injectable } from '@nestjs/common';
import { CreateActivityImageDto } from './dto/create-activity-image.dto';
import { UpdateActivityImageDto } from './dto/update-activity-image.dto';
import { Model } from 'mongoose';
import { InjectModel } from '@nestjs/mongoose';
import { ActivityImages } from 'src/database/schemas/activity-image.schema';

@Injectable()
export class ActivityImagesService {
  constructor(
    @InjectModel(ActivityImages.name) private activityImage: Model<ActivityImages>,
  ) {}
  async create(id: any, files: Array<Express.Multer.File>) {
    const activityImages: Array<CreateActivityImageDto> = [];

    files.forEach((file) => {
      activityImages.push({
        filename: file.filename,
        activity: id,
      });
    });

    await this.activityImage.insertMany(activityImages);
    const resId = await this.activityImage.find({ post: id }).select('_id');
    return resId;
  }

  findAll() {
    return `This action returns all activityImages`;
  }

  findOne(id: number) {
    return `This action returns a #${id} activityImage`;
  }

  update(id: number, updateDto: UpdateActivityImageDto) {
    return `This action updates a #${id} activityImage`;
  }

  remove(id: number) {
    return `This action removes a #${id} activityImage`;
  }
}
