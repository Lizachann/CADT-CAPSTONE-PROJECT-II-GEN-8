import { ForbiddenException, Injectable } from '@nestjs/common';
import { CreateAdminDto } from './dto/create-admin.dto';
import { UpdateAdminDto } from './dto/update-admin.dto';
import { InjectModel } from '@nestjs/mongoose';
import { Admin, AdminDocument } from 'src/database/schemas/admin.schema';
import { Model } from 'mongoose';
import * as argon2 from 'argon2';
import {
  Credential,
  CredentialDocument,
} from 'src/database/schemas/credential.schema';

@Injectable()
export class AdminsService {
  constructor(
    @InjectModel(Admin.name) private adminModel: Model<AdminDocument>,
    @InjectModel(Credential.name)
    private credentialModel: Model<CredentialDocument>,
  ) {}

  async create(createAdminDto: CreateAdminDto) {
    // Hash the password using argon2
    createAdminDto.password = await argon2.hash(createAdminDto.password);

    // Check if email is already taken
    const existingCredential = await this.credentialModel.findOne({
      email: createAdminDto.email,
    });
    if (existingCredential) {
      throw new ForbiddenException({
        message: 'Email is already taken',
      });
    }

    // Create and save the Credential document
    const userCredential = new this.credentialModel({
      email: createAdminDto.email,
      password: createAdminDto.password,
    });

    await userCredential.save().catch((error) => {
      if (error?.code === 11000) {
        // MongoDB duplicate key error code
        throw new ForbiddenException({
          message: 'Phone number is already taken.',
        });
      }
    });

    // Create and save the Admin document with a reference to the Credential
    const newAdmin = new this.adminModel({
      credential: userCredential._id,
      username: createAdminDto.username,
      profile_img: createAdminDto.profile_img,
    });

    await newAdmin.save();

    return {
      user: newAdmin,
      message: 'User Created Successfully.',
    };
  }

  async findAll() {
    const res = await this.adminModel.find().populate(['credential']).exec();

    return res;
  }

  findOne(id: string) {
    return `This action returns a #${id} admin`;
  }

  update(id: string, updateAdminDto: UpdateAdminDto) {
    return `This action updates a #${id} admin`;
  }

  remove(id: string) {
    return `This action removes a #${id} admin`;
  }
}
