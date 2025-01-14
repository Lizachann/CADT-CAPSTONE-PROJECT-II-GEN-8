import { ApiProperty } from '@nestjs/swagger';
import {
  IsArray,
  IsBoolean,
  IsEmail,
  IsEnum,
  IsNumber,
  IsOptional,
  IsString,
} from 'class-validator';
import { GENDER } from 'src/constants/gender-constant';
import { ROLES } from 'src/constants/roles-constant';

export class CreateTherapistDto {
  @ApiProperty()
  @IsString()
  first_name: string;

  @ApiProperty()
  @IsString()
  last_name: string;

  @ApiProperty()
  @IsString()
  @IsOptional()
  bio?: string;

  @ApiProperty({ uniqueItems: true })
  @IsString()
  username: string;

  @ApiProperty({ uniqueItems: true })
  @IsEmail()
  email: string;

  @ApiProperty()
  @IsNumber()
  hourly_rate: number;

  @ApiProperty({ uniqueItems: true })
  @IsString()
  phone_number: string;

  @ApiProperty({ isArray: true, type: String })
  @IsArray()
  @IsOptional()
  specializations?: string[];

  @ApiProperty({ enum: GENDER })
  @IsEnum(GENDER)
  gender: string;

  @ApiProperty({ enum: ROLES, default: [ROLES.THERAPIST], isArray: true })
  @IsArray()
  @IsOptional()
  roles?: Array<ROLES>;

  @ApiProperty({ default: false })
  @IsOptional()
  @IsBoolean()
  is_deleted?: boolean;
}
