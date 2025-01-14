import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsNumber, IsString } from 'class-validator';

export class CreateStressMonitorDto {
  @ApiProperty()
  @IsNotEmpty()
  @IsNumber()
  total_score: number;

  @ApiProperty()
  @IsNotEmpty()
  @IsString()
  patient: string;
}
