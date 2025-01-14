import { ApiProperty } from '@nestjs/swagger';
import {
  IsEmail,
  IsEnum,
  IsNotEmpty,
  IsNumber,
  IsOptional,
  IsPhoneNumber,
  IsString,
  MaxLength,
  MinLength,
} from 'class-validator';
import { GENDER } from 'src/constants/gender-constant';

export class UpdateBalanceDto {
  @ApiProperty()
  @IsNumber()
  credits: number;
}
