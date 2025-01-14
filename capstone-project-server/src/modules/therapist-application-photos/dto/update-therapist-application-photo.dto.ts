import { PartialType } from '@nestjs/swagger';
import { CreateTherapistApplicationPhotoDto } from './create-therapist-application-photo.dto';

export class UpdateTherapistApplicationPhotoDto extends PartialType(CreateTherapistApplicationPhotoDto) {}
