import {
  BadRequestException,
  Injectable,
  NotFoundException,
  UnauthorizedException,
} from '@nestjs/common';
import { CreatePostDto } from './dto/create-post.dto';
import { UpdatePostDto } from './dto/update-post.dto';
import { InjectModel } from '@nestjs/mongoose';
import { Post } from 'src/database/schemas/post.schema';
import { isValidObjectId, Model } from 'mongoose';
import { Patient } from 'src/database/schemas/patient.schema';
import { getPaginateMeta } from 'src/common/paginate';
import { PaginationParamDto } from 'src/common/dto/pagination-param.dto';
import { PostPhotosService } from '../post-photos/post-photos.service';
import { PatientComment } from 'src/database/schemas/patient-comment.schema';
import { HttpService } from '@nestjs/axios';
import { firstValueFrom } from 'rxjs';
import { ML_ROUTE_ENUM } from 'src/constants/ml-route-constant';
import { ConfigService } from '@nestjs/config';
import { ML_BASE_URL } from 'src/constants/env-constants';
import { MODEL } from 'src/constants/model-constant';

@Injectable()
export class PostsService {
  constructor(
    @InjectModel(Post.name) private postModel: Model<Post>,
    @InjectModel(Patient.name) private patientModel: Model<Patient>,
    @InjectModel(PatientComment.name)
    private patientCommentModel: Model<PatientComment>,
    private postPhotosService: PostPhotosService,
    private readonly httpService: HttpService,
    private readonly configService: ConfigService,
  ) {}

  async sendPostBodyRequest(postBody: string) {
    const url = this.configService.getOrThrow(ML_BASE_URL);
    const data = { text: postBody };

    const response = await firstValueFrom(
      this.httpService.post(url + ML_ROUTE_ENUM.PREDICT_STRESS, data),
    );
    return response.data;
  }

  async create(
    createPostDto: CreatePostDto,
    files: Array<Express.Multer.File>,
  ) {
    const isNoFiles = !files || files?.length === 0;
    const isNoBody =
      !createPostDto.body || createPostDto.body?.trim().length === 0;
    const isEmpty = isNoBody && isNoFiles;

    if (isEmpty)
      throw new BadRequestException(
        'field: body or field: postPhotos is required',
      );

    if (!isValidObjectId(createPostDto.patient)) {
      throw new BadRequestException('Invalid Patient Id');
    }
    const findUser = await this.patientModel.findById(createPostDto.patient);

    if (!findUser) {
      throw new NotFoundException('Patient does not exist');
    }

    if (isNoFiles) delete createPostDto.postPhotos;
    const postPhotos = [];
    let stressResult = false;

    if (!isNoBody) {
      const mlRes = await this.sendPostBodyRequest(createPostDto.body);
      const { Result } = mlRes;
      stressResult = Result;
    }

    const createPostRes = await this.postModel.create({
      ...createPostDto,
      stress_result: stressResult,
    });

    if (!isNoFiles) {
      const postPhotosRes = await this.postPhotosService.create(
        createPostRes._id,
        files,
      );

      postPhotosRes.forEach((postPhoto) => {
        const { _id } = postPhoto;
        postPhotos.push(_id);
      });

      await createPostRes.updateOne({
        $push: {
          postPhotos: [...postPhotos],
        },
      });
    }

    await findUser.updateOne({
      $push: {
        posts: createPostRes._id,
      },
    });

    return createPostRes;
  }

  async findAll(pagination: PaginationParamDto) {
    const { page = 1, limit = 10 } = pagination;
    const skip = page * limit - limit;
    const res = await this.postModel
      .find()
      .limit(limit)
      .skip(skip)
      .sort({
        createdAt: 'desc',
      })
      .populate(['postPhotos'])
      .populate({
        path: 'patient',
        populate: {
          path: 'credential',
          model: MODEL.Credential,
        },
      })
      .exec();

    return {
      data: res,
      meta: await getPaginateMeta({
        model: this.postModel,
        resLength: res.length,
        limit,
        page,
      }),
    };
  }

  async findOne(id: string) {
    if (!isValidObjectId(id))
      throw new BadRequestException('Invalid patient post id');

    const res = await this.postModel
      .findOne({
        _id: id,
      })
      .populate(['postPhotos'])
      .populate({
        path: 'patient',
        populate: {
          path: 'credential',
          model: MODEL.Credential,
        },
      });

    if (!res) throw new NotFoundException();

    return res;
  }

  async findPatientPost(patientId: string) {
    if (!isValidObjectId(patientId))
      throw new BadRequestException('Invalid patient patient id');

    const res = await this.postModel
      .find({ patient: patientId, is_deleted: false })
      .populate(['patient', 'postPhotos']);

    if (res.length === 0) {
      return {
        message: 'No post by patient',
        statusCode: 204,
        data: [],
      };
    }

    return res;
  }

  async update(id: string, updatePostDto: UpdatePostDto) {
    const res = await this.postModel.updateOne(
      { _id: id },
      { ...updatePostDto },
    );
    return {
      data: {
        res,
        field: updatePostDto,
      },
    };
  }

  async userRemovePost(id: string, body: { patient_id: string }) {
    const { patient_id } = body;
    const findPatient = await this.patientModel.findById(patient_id);
    const findPost = await this.postModel.findById(id);

    if (!findPatient) {
      throw new UnauthorizedException();
    }

    if (findPatient._id.toString() !== findPost.patient.toString()) {
      throw new UnauthorizedException('Not the owner of post');
    }

    const res = await this.postModel.updateOne(
      { _id: id },
      { is_deleted: true },
    );

    // find comments and remove
    await this.patientCommentModel.updateMany(
      {
        post: id,
      },
      {
        $set: {
          is_deleted: true,
        },
      },
    );

    return res;
  }

  async remove(id: string, body: { patient_id: string }) {
    const { patient_id } = body;

    const findPost = await this.postModel.findById(id);
    const findPatient = await this.patientModel.findById(patient_id);
    if (!findPost) {
      throw new NotFoundException('Post does not exist');
    }

    if (findPost.patient.toString() !== findPatient._id.toString()) {
      throw new UnauthorizedException('Not the owner of post');
    }

    const res = await findPost.deleteOne({ _id: id });
    return res;
  }
}
