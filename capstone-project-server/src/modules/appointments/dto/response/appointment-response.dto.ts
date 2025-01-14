import { ApiProperty } from '@nestjs/swagger';
import { BaseResponse } from 'src/common/base-response.dto';
import { APNT_STATUS } from 'src/constants/apnt-status-constant';
import { PatientResponseDto } from 'src/modules/patients/dto/response/patient-response.dto';
import { TherapistResponseDto } from 'src/modules/therapists/response/therapist-response.dto';

export class AppointmentResponseDto extends BaseResponse {
  @ApiProperty({ type: String })
  note: string;

  @ApiProperty({ type: String })
  prescriptions: string;

  @ApiProperty({ type: String })
  symptoms: string;

  @ApiProperty({ type: Date })
  scheduleDate: Date;

  @ApiProperty({ type: APNT_STATUS, enum: APNT_STATUS })
  status: string;

  @ApiProperty({ type: PatientResponseDto })
  patient: string;

  @ApiProperty({ type: TherapistResponseDto })
  therapist: string;

  /**
   * @description Will return in `HH:mm` format
   * @returns String
   */
  @ApiProperty({ type: String })
  start_time: string;

  /**
   * @description Will return in `HH:mm` format
   * @returns String
   */
  @ApiProperty({ type: String })
  end_time: string;

  @ApiProperty({ type: Number })
  duration: number;

  @ApiProperty({ type: Number })
  session_price: number;
}
