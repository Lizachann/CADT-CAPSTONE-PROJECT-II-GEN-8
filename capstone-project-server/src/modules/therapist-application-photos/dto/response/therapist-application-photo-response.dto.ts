import { ApiProperty } from '@nestjs/swagger';
import { BaseResponse } from 'src/common/base-response.dto';
import { TherapistRegistrationReponseDto } from 'src/modules/therapists/response/therapist-registration-response.dto';

export class TherapistApplicationPhotoResponse extends BaseResponse {
  @ApiProperty()
  filename: string;

  @ApiProperty({ type: TherapistRegistrationReponseDto })
  therapist_application: string;
}
