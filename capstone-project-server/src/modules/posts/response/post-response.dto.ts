import { ApiProperty } from '@nestjs/swagger';
import { BaseResponse } from 'src/common/base-response.dto';
import { PatientResponseDto } from 'src/modules/patients/dto/response/patient-response.dto';

export class PostResponseDto extends BaseResponse {
  @ApiProperty({ type: String })
  body: string;

  @ApiProperty({ type: PatientResponseDto })
  patient: string;

  @ApiProperty({ type: Number })
  like_count: number;

  @ApiProperty({ type: Number })
  save_count: number;

  @ApiProperty({ type: Number })
  comment_count: number;

  @ApiProperty({ type: Boolean, default: false })
  stress_result: boolean;
}
