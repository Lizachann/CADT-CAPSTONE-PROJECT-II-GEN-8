import { Injectable } from '@nestjs/common';
import { CreateTherapistApplicationPhotoDto } from './dto/create-therapist-application-photo.dto';
import { UpdateTherapistApplicationPhotoDto } from './dto/update-therapist-application-photo.dto';
import { InjectModel } from '@nestjs/mongoose';
import { TherapistApplicationPhoto } from 'src/database/schemas/therapist-application-photo.schema';
import { Model } from 'mongoose';

@Injectable()
export class TherapistApplicationPhotosService {
  constructor(
    @InjectModel(TherapistApplicationPhoto.name)
    private therapistApplicationPhotos: Model<TherapistApplicationPhoto>,
  ) {}

  async create(id: any, files: Array<Express.Multer.File>) {
    const therapistPhotos: Array<CreateTherapistApplicationPhotoDto> = [];

    files.forEach((file) => {
      therapistPhotos.push({
        filename: file.filename,
        therapist_application: id,
      });
    });

    await this.therapistApplicationPhotos.insertMany(therapistPhotos);
    const resId = await this.therapistApplicationPhotos
      .find({ therapist_application: id })
      .select('_id');

    return resId;
  }

  findAll() {
    return `This action returns all therapistApplicationPhotos`;
  }

  findOne(id: number) {
    return `This action returns a #${id} therapistApplicationPhoto`;
  }

  update(
    id: number,
    updateTherapistApplicationPhotoDto: UpdateTherapistApplicationPhotoDto,
  ) {
    return `This action updates a #${id} therapistApplicationPhoto`;
  }

  remove(id: number) {
    return `This action removes a #${id} therapistApplicationPhoto`;
  }
}
