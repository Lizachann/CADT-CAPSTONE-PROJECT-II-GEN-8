import { PartialType } from '@nestjs/swagger';
import { CreatePostPhotoDto } from './create-post-photo.dto';

export class UpdatePostPhotoDto extends PartialType(CreatePostPhotoDto) {}
