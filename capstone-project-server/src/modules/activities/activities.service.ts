import { BadRequestException, Injectable, NotFoundException } from '@nestjs/common';
import { CreateActivityDto } from './dto/create-activity.dto';
import { UpdateActivityDto } from './dto/update-activity.dto';
import { Model, Types } from 'mongoose';
import { ActivityImagesService } from '../activities-images/activity-images.service';
import { InjectModel } from '@nestjs/mongoose';
import { Activity } from 'src/database/schemas/activity.schema';
import { ActivityImages } from 'src/database/schemas/activity-image.schema';

@Injectable()
export class ActivitiesService {
  constructor(
    @InjectModel(Activity.name) private activitiesModel: Model<Activity>,
    @InjectModel(ActivityImages.name)
    private activityImagesModel: Model<ActivityImages>,
    private activityImagesService: ActivityImagesService,
  ) {}
  async create(
    createDto: CreateActivityDto,
    files: Array<Express.Multer.File>,
  ) {
    console.log(createDto);
    const isEmpty =
      createDto.description?.trim().length === 0 &&
      (!files || files.length === 0);
    if (isEmpty)
      throw new BadRequestException(
        'Description and files cannot both be empty',
      );

    if (!files || files.length === 0) {
      delete createDto.activityImages;
    }

    const activityImages: Types.ObjectId[] = [];

    const createActivityRes = await this.activitiesModel.create(createDto);

    if (files && files.length > 0) {
      const activityImagesRes = await this.activityImagesService.create(
        createActivityRes._id,
        files,
      );

      activityImagesRes.forEach((activityImage) => {
        const { _id } = activityImage;
        activityImages.push(_id);
      });

      await createActivityRes.updateOne({
        $set: {
          activityImages,
        },
      });
    }

    return createActivityRes;
  }

  async findAll() {
    const res = await this.activitiesModel
      .find()
      .sort({
        createdAt: 'desc',
      })
      .populate(['postImages'])
      .exec();

    return {
      data: res,
    };
  }

  async findOne(id: string) {
    const res = await this.activitiesModel
      .findOne({
        _id: id,
      })
      .populate(['postImages']);

    if (!res) throw new NotFoundException();

    return res;
  }

  async update(id: string, updateDto: UpdateActivityDto) {
    const res = await this.activitiesModel.updateOne(
      { _id: id },
      { ...updateDto },
    );
    return {
      data: {
        res,
        field: updateDto,
      },
    };
  }
  remove(id: string) {
    return `This action removes a #${id} activity`;
  }
}
