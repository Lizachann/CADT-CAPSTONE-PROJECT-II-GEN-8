import { ApiProperty } from '@nestjs/swagger';
import { BaseResponse } from 'src/common/base-response.dto';
import { Patient } from 'src/database/schemas/patient.schema';
import { PatientResponseDto } from 'src/modules/patients/dto/response/patient-response.dto';

export class StressMonitorResponseDto extends BaseResponse {
  @ApiProperty({ type: PatientResponseDto })
  patient: Patient;

  @ApiProperty({ type: Number })
  total_score: number;
}

export class StressMonitorCountResponseDto {
  @ApiProperty({ type: Number, default: 0 })
  stressMonitorCount: number;
}
