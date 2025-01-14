import { ApiProperty } from '@nestjs/swagger';
import {
  IsDate,
  IsEnum,
  IsNumber,
  IsOptional,
  IsString,
} from 'class-validator';
import { Type } from 'class-transformer';
import { APNT_STATUS } from 'src/constants/apnt-status-constant';

export class CreateAppointmentDto {
  @ApiProperty()
  @IsString()
  @IsOptional()
  note?: string;

  @ApiProperty()
  @IsString()
  @IsOptional()
  prescriptions?: string;

  @ApiProperty()
  @IsString()
  @IsOptional()
  symptoms: string;

  @ApiProperty()
  @IsString()
  patient: string;

  @ApiProperty()
  @IsString()
  therapist: string;

  @ApiProperty()
  @IsDate()
  @Type(() => Date)
  scheduleDate: Date;

  @ApiProperty()
  @IsOptional()
  @IsEnum(APNT_STATUS)
  status: string;

  @ApiProperty()
  @IsString()
  start_time: string;

  @ApiProperty()
  @IsString()
  end_time: string;

  @ApiProperty()
  @IsNumber()
  duration: number;

  @ApiProperty()
  @IsNumber()
  @IsOptional()
  session_price?: number;
}
