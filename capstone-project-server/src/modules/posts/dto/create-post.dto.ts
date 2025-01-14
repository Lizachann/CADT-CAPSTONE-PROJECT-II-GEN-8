import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsOptional, IsString, MaxLength } from 'class-validator';

export class CreatePostDto {
  @ApiProperty()
  @IsString()
  @IsOptional()
  @MaxLength(1000)
  body?: string;

  @ApiProperty()
  @IsNotEmpty()
  @IsString()
  patient: string;

  @ApiProperty({ type: String, isArray: true })
  @IsOptional()
  postPhotos?: Array<string>;
}
