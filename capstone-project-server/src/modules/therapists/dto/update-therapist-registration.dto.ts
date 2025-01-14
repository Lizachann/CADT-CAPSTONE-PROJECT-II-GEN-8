import { PartialType } from '@nestjs/swagger';
import { TherapistRegistrationDto } from './therapist-registration.dto';

export class UpdateTherapistRegistration extends PartialType(
  TherapistRegistrationDto,
) {}
