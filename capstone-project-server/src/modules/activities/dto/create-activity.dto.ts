import { ApiProperty } from '@nestjs/swagger';
import { IsOptional, IsString, MaxLength } from 'class-validator';

export class CreateActivityDto {
  @ApiProperty()
  @IsString()
  title: string;

  @ApiProperty()
  @IsString()
  @IsOptional()
  @MaxLength(1000)
  description?: string;

  @ApiProperty()
  @IsString()
  @MaxLength(100)
  type: string;

  @ApiProperty()
  @IsString()
  @MaxLength(1000)
  fitness?: string;

  @ApiProperty()
  @IsString()
  @MaxLength(1000)
  mentalHealth?: string;

  @ApiProperty()
  @IsString()
  @MaxLength(1000)
  socialSkill?: string;

  @ApiProperty()
  @IsString()
  @MaxLength(1000)
  development?: string;

  @ApiProperty()
  @IsString()
  @MaxLength(1000)
  stresslvl?: number;

  @ApiProperty({ type: String, isArray: true })
  @IsOptional()
  activityImages?: string;
}
