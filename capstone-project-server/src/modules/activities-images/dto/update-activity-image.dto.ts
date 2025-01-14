import { PartialType } from '@nestjs/swagger';
import { CreateActivityImageDto } from './create-activity-image.dto';

export class UpdateActivityImageDto extends PartialType(CreateActivityImageDto) {}
