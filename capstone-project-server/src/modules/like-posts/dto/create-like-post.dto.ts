import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString } from 'class-validator';

export class CreateLikePostDto {
  @ApiProperty({ type: String })
  @IsNotEmpty()
  @IsString()
  patient: string;

  @ApiProperty({ type: String })
  @IsNotEmpty()
  @IsString()
  post: string;
}
