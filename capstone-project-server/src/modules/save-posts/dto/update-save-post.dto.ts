import { PartialType } from '@nestjs/swagger';
import { CreateSavedPostDto } from './create-save-post.dto';

export class UpdateSavedPostDto extends PartialType(CreateSavedPostDto) {}
