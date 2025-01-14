import { PartialType } from '@nestjs/swagger';
import { CreateLikePostDto } from './create-like-post.dto';

export class UpdateLikePostDto extends PartialType(CreateLikePostDto) {}
