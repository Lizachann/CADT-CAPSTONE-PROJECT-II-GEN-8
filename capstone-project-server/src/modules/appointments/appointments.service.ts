import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { CreateAppointmentDto } from './dto/create-appointment.dto';
import { UpdateAppointmentDto } from './dto/update-appointment.dto';
import { InjectModel } from '@nestjs/mongoose';
import { Therapist } from 'src/database/schemas/therapist.schema';
import { Patient } from 'src/database/schemas/patient.schema';
import { isValidObjectId, Model } from 'mongoose';
import { Appointment } from 'src/database/schemas/appointment.schema';
import { FilterAppointmentDto } from './dto/filter-appointment.dto';
import { compareDates, timeStringToDate } from 'src/utils/helpter';
import { PatientsService } from '../patients/patients.service';

@Injectable()
export class AppointmentsService {
  constructor(
    @InjectModel(Patient.name) private patientModel: Model<Patient>,
    @InjectModel(Therapist.name) private therapistModel: Model<Therapist>,
    @InjectModel(Appointment.name) private appointmentModel: Model<Appointment>,
    private patientsService: PatientsService,
  ) {}

  async create(createAppointmentDto: CreateAppointmentDto) {
    const { start_time, end_time, scheduleDate } = createAppointmentDto;

    const startDate = timeStringToDate({
      time: start_time,
      date: scheduleDate,
    });
    const endDate = timeStringToDate({ time: end_time, date: scheduleDate });

    console.log(startDate, endDate);

    if (!compareDates(startDate, endDate)) {
      throw new BadRequestException(
        `Start time: ${startDate} must start before end time: ${endDate}`,
      );
    }

    //Check if patient ID is valid
    if (!isValidObjectId(createAppointmentDto.patient)) {
      throw new BadRequestException('Invalid Patient Id');
    }

    const foundPatient = await this.patientModel
      .findOne({
        _id: createAppointmentDto.patient,
      })
      .exec();

    if (!foundPatient) {
      throw new NotFoundException('Patient does not exist');
    }
    //Check if therapist ID is valid
    if (!isValidObjectId(createAppointmentDto.therapist)) {
      throw new BadRequestException('Invalid Therapist Id');
    }

    const foundTherapist = await this.therapistModel
      .findOne({
        _id: createAppointmentDto.therapist,
      })
      .exec();

    if (!foundTherapist) {
      throw new NotFoundException('Therapist does not exist');
    }

    const total_price = (createAppointmentDto.session_price =
      createAppointmentDto.duration * foundTherapist.hourly_rate);
    if (foundPatient.credits < total_price) {
      throw new BadRequestException(
        `Coin is not enough for booking. Please top up!`,
      );
    } else {
      await this.patientsService.update(foundPatient.id, {
        credits: foundPatient.credits - total_price,
      });
    }

    createAppointmentDto.session_price = total_price;

    const res = await this.appointmentModel.create(createAppointmentDto);
    return res;
  }

  async findAll(queryParams: FilterAppointmentDto) {
    const { status } = queryParams;
    let res: any;
    if (!status) {
      res = await this.appointmentModel
        .find()
        .sort({
          updatedAt: 'desc',
        })
        .populate(['patient', 'therapist']);
    } else {
      res = await this.appointmentModel
        .find({
          status,
        })
        .sort({
          updatedAt: 'desc',
        })
        .populate(['patient', 'therapist']);
    }
    return res;
  }

  async findOne(id: string) {
    const res = await this.appointmentModel
      .findOne({
        _id: id,
      })
      .populate(['patient', 'therapist']);
    return res;
  }

  async update(id: string, updateAppointmentDto: UpdateAppointmentDto) {
    const appointment = await this.appointmentModel.findOne({
      _id: id,
    });
    if (!appointment) {
      throw new NotFoundException('Appointment does not exist');
    }

    //Update the status of the appointment
    const res = await appointment.updateOne(updateAppointmentDto);

    return res;
  }

  remove(id: string) {
    return `This action removes a #${id} appointment`;
  }
}
