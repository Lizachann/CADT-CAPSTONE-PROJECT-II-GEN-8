import { ApiProperty } from '@nestjs/swagger';
import { IsEmail, IsEnum, IsOptional, IsString } from 'class-validator';
import { THERAPIST_APPLICATION_STATUS } from 'src/constants/therapist-application-constant';

export class TherapistRegistrationDto {
  @ApiProperty()
  @IsString()
  first_name: string;

  @ApiProperty()
  @IsString()
  last_name: string;

  @ApiProperty({ uniqueItems: true })
  @IsEmail()
  email: string;

  @ApiProperty()
  @IsOptional()
  @IsEnum(THERAPIST_APPLICATION_STATUS)
  status: string;

  @ApiProperty({ type: String, isArray: true })
  @IsOptional()
  therapistApplicationPhotos?: Array<string>;
}
