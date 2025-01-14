import { ApiProperty, OmitType } from '@nestjs/swagger';
import { CreatePostDto } from './create-post.dto';
import { IsOptional, MaxLength } from 'class-validator';

export class UpdatePostDto extends OmitType(CreatePostDto, [
  'patient',
] as const) {
  @ApiProperty({ type: Boolean, default: false })
  @IsOptional()
  is_deleted: boolean;

  @ApiProperty({ type: String, maxLength: 1000 })
  @IsOptional()
  @MaxLength(1000)
  body: string;
}
