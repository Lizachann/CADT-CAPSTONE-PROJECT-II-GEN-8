import { Injectable, NotFoundException } from '@nestjs/common';
import { CreatePatientDto } from './dto/create-patient.dto';
import { UpdatePatientDto } from './dto/update-patient.dto';
import { InjectModel } from '@nestjs/mongoose';
import { Patient } from 'src/database/schemas/patient.schema';
import { Model } from 'mongoose';
import { Post } from 'src/database/schemas/post.schema';
import { getPaginateMeta } from 'src/common/paginate';
import { PaginationParamDto } from 'src/common/dto/pagination-param.dto';
import { UpdateBalanceDto } from './dto/update-balance.dto';

@Injectable()
export class PatientsService {
  constructor(
    @InjectModel(Patient.name) private patientModel: Model<Patient>,
    @InjectModel(Post.name) private postModel: Model<Post>,
  ) {}

  async create(createPatientDto: CreatePatientDto) {
    const res = await this.patientModel.create({
      ...createPatientDto,
    });
    return res;
  }

  async addCredits(id: string, updateBalanceDto: UpdateBalanceDto) {
    const foundPatient = await this.patientModel
      .findOne({
        _id: id,
      })
      .exec();

    if (!foundPatient) {
      throw new NotFoundException('User Not Found.');
    }

    const res = await this.update(foundPatient.id, {
      credits: foundPatient.credits + updateBalanceDto.credits,
    });
    return res;
  }

  async findAll(pagination: PaginationParamDto) {
    const { limit = 10, page = 1 } = pagination;
    const skip = page * limit - limit;
    const res = await this.patientModel
      .find()
      .limit(limit)
      .skip(skip)
      .populate(['posts', 'credential'])
      .exec();

    return {
      data: res,
      meta: {
        ...(await getPaginateMeta({
          model: this.patientModel,
          limit,
          page,
          resLength: res.length,
        })),
      },
    };
  }

  async findOne(id: string) {
    const res = await this.patientModel.findById(id).populate(['posts', 'credential']);
    if (!res) {
      throw new NotFoundException();
    }
    return res;
  }

  async update(id: string, updatePatientDto: UpdatePatientDto) {
    const res = await this.patientModel
      .updateOne({ _id: id }, { ...updatePatientDto })
      .exec();
    return {
      data: {
        res,
        field: updatePatientDto,
      },
    };
  }

  async banPatient(id: string) {
    const res = await this.patientModel.updateOne(
      { _id: id },
      { is_banned: true },
    );

    return res;
  }

  async unbanPatient(id: string) {
    const res = await this.patientModel.updateOne(
      { _id: id },
      { is_banned: false },
    );

    return res;
  }

  async remove(id: string) {
    const res = await this.patientModel.deleteOne({ _id: id });

    /** deletes post related to user */
    await this.postModel.deleteMany({ patient: id });

    return res;
  }
}
