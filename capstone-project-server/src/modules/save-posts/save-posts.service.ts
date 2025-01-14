import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateSavedPostDto } from './dto/create-save-post.dto';
import { UpdateSavedPostDto } from './dto/update-save-post.dto';
import { InjectModel } from '@nestjs/mongoose';
import { SavePost } from 'src/database/schemas/save-post.schema';
import { Model } from 'mongoose';
import { Post } from 'src/database/schemas/post.schema';
import { MODEL } from 'src/constants/model-constant';
import { Patient } from 'src/database/schemas/patient.schema';

@Injectable()
export class SavedPostsService {
  constructor(
    @InjectModel(SavePost.name) private savedPostsModel: Model<SavePost>,
    @InjectModel(Post.name) private postsModel: Model<Post>,
    @InjectModel(Patient.name) private patientModel: Model<Patient>,
  ) {}

  async create(createSavedPostDto: CreateSavedPostDto) {
    const res = await this.savedPostsModel.create(createSavedPostDto);
    return res;
  }

  async findAll() {
    const res = await this.savedPostsModel.find().populate(['patient', 'post']);
    return res;
  }

  async findOne(id: string) {
    const res = await this.savedPostsModel
      .findOne({ _id: id })
      .populate(['patient', 'post']);
    return res;
  }

  async findPatientSavedPosts(patientId: string) {
    const res = await this.savedPostsModel
      .find({
        patient: patientId,
        is_saved: true,
      })
      .populate({
        path: 'post',
        populate: {
          path: 'patient',
          model: MODEL.Patient,
        },
      });

    return res;
  }

  private async updatePostSaveCount(postId: string) {
    const saveCount = await this.savedPostsModel
      .find({
        is_saved: true,
        post: postId,
      })
      .countDocuments();

    await this.postsModel.findOneAndUpdate(
      {
        _id: postId,
      },
      {
        $set: {
          save_count: saveCount,
        },
      },
    );

    return saveCount;
  }

  async update(id: string, updateSavedPostDto: UpdateSavedPostDto) {
    // get original post
    const post = await this.postsModel.findOne({
      _id: id,
    });
    if (!post) throw new NotFoundException('Post not found');

    const findPatient = await this.patientModel.findOne({
      _id: updateSavedPostDto.patient,
    });
    if (!findPatient)
      throw new NotFoundException(`Patient ${id} does not exist`);

    // find saved post record
    const findSavedPost = await this.savedPostsModel
      .findOne({
        post: id,
        patient: updateSavedPostDto.patient,
      })
      .populate(['post']);

    // if not exist
    if (!findSavedPost) {
      const res = await this.savedPostsModel.create({
        patient: updateSavedPostDto.patient,
        post: id,
      });

      await this.updatePostSaveCount(id);

      return {
        message: 'Save',
        data: res,
      };
    }

    // if exist and is saved
    if (findSavedPost.is_saved) {
      const res = await findSavedPost.updateOne({
        is_saved: false,
      });

      await this.updatePostSaveCount(id);

      return {
        message: 'Unsaved',
        data: res,
      };
    }

    const res = await findSavedPost.updateOne({
      is_saved: true,
    });
    await this.updatePostSaveCount(id);

    return {
      message: 'Save',
      data: res,
    };
  }
}
