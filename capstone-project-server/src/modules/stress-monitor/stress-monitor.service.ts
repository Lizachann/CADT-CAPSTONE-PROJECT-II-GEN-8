import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { CreateStressMonitorDto } from './dto/create-stress-monitor.dto';
import { InjectModel } from '@nestjs/mongoose';
import { StressMonitor } from 'src/database/schemas/stress-monitor.schema';
import { isValidObjectId, Model } from 'mongoose';
import { Patient } from 'src/database/schemas/patient.schema';

@Injectable()
export class StressMonitorService {
  constructor(
    @InjectModel(StressMonitor.name)
    private stressMonitorModel: Model<StressMonitor>,
    @InjectModel(Patient.name) private patientModel: Model<Patient>,
  ) {}

  async findStressMonitorCount(patientId: string) {
    const res = await this.stressMonitorModel
      .find({ patient: patientId })
      .countDocuments();

    return {
      stressMonitorCount: res,
    };
  }

  async updateStressMonitorCount(patientId: string) {
    if (!isValidObjectId(patientId))
      throw new BadRequestException('Invalid patient id');

    const findPatient = await this.patientModel.findOne({ _id: patientId });
    if (!findPatient)
      throw new NotFoundException(`Patient: ${patientId} does not exist`);

    const checkupCountRes = await this.findStressMonitorCount(patientId);

    const { stressMonitorCount } = checkupCountRes;

    const res = await findPatient.updateOne({
      stress_monitor_count: stressMonitorCount,
    });

    return res;
  }

  async create(createStressMonitorDto: CreateStressMonitorDto) {
    const { patient, total_score } = createStressMonitorDto;
    if (!isValidObjectId(patient))
      throw new BadRequestException('Invalid patient id');

    // check if patient exists
    const findPatient = await this.patientModel.findOne({ _id: patient });
    if (!findPatient)
      throw new NotFoundException(`Patient: ${patient} does not exist`);

    if (total_score < 0)
      throw new BadRequestException(
        'Total score must be greater than or equal to 0',
      );

    const res = await this.stressMonitorModel.create(createStressMonitorDto);

    await this.updateStressMonitorCount(createStressMonitorDto.patient);

    return res;
  }

  /**
   * @description Find all stress monitor
   */
  async findAll() {
    const res = await this.stressMonitorModel.find().populate(['patient']);

    return res;
  }

  /**
   * @description Find stress monitor by patient id
   */
  async findOne(patientId: string) {
    if (!isValidObjectId(patientId))
      throw new BadRequestException('Invalid patient id');

    // check if patient exists
    const findPatient = await this.patientModel.findOne({ _id: patientId });
    if (!findPatient)
      throw new NotFoundException(`Patient: ${patientId} does not exist`);

    const res = await this.stressMonitorModel
      .find({ patient: patientId })
      .populate(['patient']);

    return res;
  }

  // update(id: number, updateStressMonitorDto: UpdateStressMonitorDto) {
  //   return `This action updates a #${id} stressMonitor`;
  // }

  // remove(id: number) {
  //   return `This action removes a #${id} stressMonitor`;
  // }
}
