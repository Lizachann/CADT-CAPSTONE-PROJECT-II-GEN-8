import { ApiProperty } from '@nestjs/swagger';
import { IsArray, IsOptional, IsString, MinLength } from 'class-validator';

export class CreatePatientCommentDto {
  @ApiProperty()
  @IsString()
  @MinLength(1)
  content: string;

  @ApiProperty()
  @IsString()
  patient: string;

  @ApiProperty()
  @IsString()
  post: string;

  @ApiProperty({ type: String, required: false })
  @IsOptional()
  @IsString()
  parent?: string;

  @ApiProperty({ type: String, required: false, isArray: true })
  @IsOptional()
  @IsArray()
  children?: Array<string>;
}
