import { ApiProperty } from '@nestjs/swagger';
import { IsEnum, IsOptional, IsString } from 'class-validator';
import { APNT_STATUS } from 'src/constants/apnt-status-constant';

export class FilterAppointmentDto {
  @ApiProperty()
  @IsString()
  @IsOptional()
  @IsEnum(APNT_STATUS)
  status?: string;
}
