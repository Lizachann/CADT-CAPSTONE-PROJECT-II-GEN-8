import { ApiProperty } from '@nestjs/swagger';
import {
  IsEnum,
  IsNotEmpty,
  IsNumber,
  IsOptional,
  IsString,
  MaxLength,
  MinLength,
} from 'class-validator';
import { GENDER } from 'src/constants/gender-constant';

export class CreatePatientDto {
  @ApiProperty({ required: false })
  @IsOptional()
  @IsNotEmpty()
  @IsString()
  credential?: string;

  @ApiProperty({ required: false })
  @IsOptional()
  @MaxLength(64)
  @MinLength(3)
  @IsString()
  username?: string;

  @ApiProperty({ required: false })
  @IsEnum(GENDER)
  @IsOptional()
  gender?: string;

  @ApiProperty({ required: false })
  @IsNumber()
  @IsOptional()
  credits?: number;

  @ApiProperty({ required: false })
  @IsString()
  @IsOptional()
  profile_img?: string;
}
