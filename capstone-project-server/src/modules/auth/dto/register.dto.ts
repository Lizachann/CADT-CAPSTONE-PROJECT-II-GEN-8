import { ApiProperty } from "@nestjs/swagger";
import { IsEmail, IsString } from "class-validator";
import { CreatePatientDto } from "src/modules/patients/dto/create-patient.dto";

export class RegisterDto extends CreatePatientDto {
  @ApiProperty()
  @IsEmail()
  email: string

  @ApiProperty()
  @IsString()
  password: string
}
