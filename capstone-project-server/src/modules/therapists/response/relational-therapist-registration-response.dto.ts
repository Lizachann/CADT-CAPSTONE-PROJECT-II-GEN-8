import { TherapistApplicationPhotoResponse } from 'src/modules/therapist-application-photos/dto/response/therapist-application-photo-response.dto';
import { TherapistRegistrationReponseDto } from './therapist-registration-response.dto';
import { ApiProperty } from '@nestjs/swagger';

export class RelationalTherapistRegistrationResponse extends TherapistRegistrationReponseDto {
  @ApiProperty({ type: TherapistApplicationPhotoResponse, isArray: true })
  therapistApplicationPhotos: Array<string>;
}
