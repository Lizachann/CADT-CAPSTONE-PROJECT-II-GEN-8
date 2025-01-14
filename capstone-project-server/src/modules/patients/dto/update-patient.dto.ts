import { ApiProperty, PartialType } from '@nestjs/swagger';
import { CreatePatientDto } from './create-patient.dto';
import { IsBoolean, IsEnum, IsOptional } from 'class-validator';
import { ROLES } from 'src/constants/roles-constant';

export class UpdatePatientDto extends PartialType(CreatePatientDto) {
  @ApiProperty()
  @IsBoolean()
  @IsOptional()
  is_banned?: boolean;

  @ApiProperty()
  @IsBoolean()
  @IsOptional()
  is_deleted?: boolean;

  @ApiProperty({ type: Array, enum: ROLES, isArray: true })
  @IsOptional()
  @IsEnum(ROLES)
  roles?: Array<ROLES>;
}
