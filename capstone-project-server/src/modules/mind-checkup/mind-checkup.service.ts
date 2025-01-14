import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { CreateMindCheckupDto } from './dto/create-mind-checkup.dto';
import { HttpService } from '@nestjs/axios';
import { ConfigService } from '@nestjs/config';
import { ML_BASE_URL } from 'src/constants/env-constants';
import { firstValueFrom } from 'rxjs';
import { ML_ROUTE_ENUM } from 'src/constants/ml-route-constant';
import { isValidObjectId, Model } from 'mongoose';
import { InjectModel } from '@nestjs/mongoose';
import { Patient } from 'src/database/schemas/patient.schema';
import { MindCheckup } from 'src/database/schemas/mind-checkup.schema';

@Injectable()
export class MindCheckupService {
  constructor(
    private readonly httpService: HttpService,
    private readonly configService: ConfigService,
    @InjectModel(MindCheckup.name) private mindCheckupModel: Model<MindCheckup>,
    @InjectModel(Patient.name) private patientModel: Model<Patient>,
  ) {}

  async sendMindCheckupRequest(createMindCheckupDto: CreateMindCheckupDto) {
    const url = this.configService.getOrThrow(ML_BASE_URL);
    const data = createMindCheckupDto;

    // remove patient attr
    delete data.patient;

    const res = await firstValueFrom(
      this.httpService.post(url + ML_ROUTE_ENUM.PREDICT_MENTAL_ISSUES, data),
    );

    return res.data;
  }

  async findCheckupCount(patientId: string) {
    const res = await this.mindCheckupModel
      .find({ patient: patientId })
      .countDocuments();

    return {
      checkupCount: res,
    };
  }

  async updateCheckupCount(patientId: string) {
    if (!isValidObjectId(patientId))
      throw new BadRequestException('Invalid patient id');

    const findPatient = await this.patientModel.findOne({ _id: patientId });
    if (!findPatient)
      throw new NotFoundException(`Patient: ${patientId} does not exist`);

    const checkupCountRes = await this.findCheckupCount(patientId);

    const { checkupCount } = checkupCountRes;

    const res = await findPatient.updateOne({
      mind_checkup_count: checkupCount,
    });

    return res;
  }

  async create(createMindCheckupDto: CreateMindCheckupDto) {
    const { patient } = createMindCheckupDto;
    if (!isValidObjectId(patient))
      throw new BadRequestException('Invalid patient id ');

    // check if patient exists
    const findPatient = await this.patientModel.findOne({ _id: patient });
    if (!findPatient)
      throw new NotFoundException(`Patient: ${patient} does not exist`);

    const res = await this.sendMindCheckupRequest(createMindCheckupDto);

    const { is_have_mental_issues } = res;

    const createCheckupDto = {
      patient: findPatient._id,
      result: is_have_mental_issues,
    };

    const createCheckup = await this.mindCheckupModel.create(createCheckupDto);

    await this.updateCheckupCount(createCheckupDto.patient.toString());

    return createCheckup;
  }

  /**
   *
   * @description Find all mind checkup
   */
  findAll() {
    const res = this.mindCheckupModel.find().populate(['patient']);
    return res;
  }

  /**
   *
   * @description Find mind checkup of a patient
   */
  async findOne(id: string) {
    if (!isValidObjectId(id))
      throw new BadRequestException('Invalid patient id');

    // check if patient exists
    const findPatient = await this.patientModel.findOne({ _id: id });
    if (!findPatient)
      throw new NotFoundException(`Patient: ${id} does not exist`);

    const res = await this.mindCheckupModel
      .find({ patient: id })
      .populate(['patient']);
    return res;
  }

  // update(id: number, updateMindCheckupDto: UpdateMindCheckupDto) {
  //   return `This action updates a #${id} mindCheckup`;
  // }

  // remove(id: number) {
  //   return `This action removes a #${id} mindCheckup`;
  // }
}
