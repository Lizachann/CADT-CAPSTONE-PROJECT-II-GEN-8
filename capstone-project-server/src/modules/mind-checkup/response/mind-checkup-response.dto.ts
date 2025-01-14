import { ApiProperty } from '@nestjs/swagger';
import { BaseResponse } from 'src/common/base-response.dto';
import { PatientResponseDto } from 'src/modules/patients/dto/response/patient-response.dto';

type TResponse = 'Yes' | 'No' | 'Maybe';

enum Response {
  Yes = 'Yes',
  No = 'No',
  Maybe = 'Maybe',
}

export class MindCheckupResponseDto extends BaseResponse {
  @ApiProperty({ enum: Response })
  result: TResponse;

  @ApiProperty({ type: PatientResponseDto })
  patient: PatientResponseDto;
}

export class CheckupCountResponseDto {
  @ApiProperty({ type: Number })
  checkupCount: number;
}
