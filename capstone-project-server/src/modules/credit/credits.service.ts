import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateCreditDto } from './dto/create-credit.dto';
import { UpdateCreditDto } from './dto/update-credit.dto';
import { InjectModel } from '@nestjs/mongoose';
import { Credit } from 'src/database/schemas/credit.schema';
import { Model } from 'mongoose';

@Injectable()
export class CreditsService {
  constructor(@InjectModel(Credit.name) private creditModel: Model<Credit>) {}

  async create(createCreditDto: CreateCreditDto) {
    const res = await this.creditModel.create(createCreditDto);
    return {
      message: 'Credit Package Created Successfully!',
      data: res,
    };
  }

  //Show only the credit that are visible
  async findAll() {
    const res = await this.creditModel
      .find({
        is_visible: true,
      })
      .exec();

    return res;
  }

  //Show all
  async getAllCredit() {
    const res = await this.creditModel.find().exec();

    return res;
  }

  async findOne(id: string) {
    const res = await this.creditModel.findOne({
      _id: id,
      is_visible: true,
    });

    if (!res) throw new NotFoundException();

    return res;
  }

  async update(id: string, updateCreditDto: UpdateCreditDto) {
    const res = await this.creditModel.updateOne(
      { _id: id },
      { ...updateCreditDto },
    );
    return {
      data: {
        res,
        field: updateCreditDto,
      },
    };
  }

  async remove(id: string) {
    const res = await this.creditModel.deleteOne({ _id: id });

    return res;
  }
}
