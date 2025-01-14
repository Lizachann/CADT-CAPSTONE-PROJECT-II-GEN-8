import { ApiProperty } from '@nestjs/swagger';
import { BaseResponse } from 'src/common/base-response.dto';
import { THERAPIST_APPLICATION_STATUS } from 'src/constants/therapist-application-constant';

export class TherapistRegistrationReponseDto extends BaseResponse {
  @ApiProperty({ type: String })
  first_name: string;

  @ApiProperty({ type: String })
  last_name: string;

  @ApiProperty({ type: String })
  email: string;

  @ApiProperty({
    type: THERAPIST_APPLICATION_STATUS,
    enum: THERAPIST_APPLICATION_STATUS,
  })
  status: string;
}
