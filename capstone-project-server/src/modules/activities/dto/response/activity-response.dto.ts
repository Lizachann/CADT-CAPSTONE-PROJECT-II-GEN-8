import { ApiProperty } from '@nestjs/swagger';
import { IsOptional, IsString, MaxLength } from 'class-validator';
import { BaseResponse } from 'src/common/base-response.dto';

export class ActivityResponseDto extends BaseResponse {
  @ApiProperty({ type: String })
  title: string;

  @ApiProperty({ type: String })
  description?: string;

  @ApiProperty()
  type: string;

  @ApiProperty()
  fitness?: string;

  @ApiProperty()
  mentalHealth?: string;

  @ApiProperty()
  socialSkill?: string;

  @ApiProperty()
  development?: string;

  @ApiProperty()
  stresslvl?: number;

  @ApiProperty({ type: String, isArray: true })
  activityImages?: string;
}
