import { ApiProperty } from '@nestjs/swagger';
import { IsOptional } from 'class-validator';

export class CreateFactoryDto {
  @ApiProperty({ default: 10, required: false })
  @IsOptional()
  length: number;
}
