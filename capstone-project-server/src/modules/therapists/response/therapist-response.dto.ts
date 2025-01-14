import { ApiProperty } from '@nestjs/swagger';
import { BaseResponse } from 'src/common/base-response.dto';
import { GENDER } from 'src/constants/gender-constant';
import { ROLES } from 'src/constants/roles-constant';

export class TherapistResponseDto extends BaseResponse {
  @ApiProperty({ type: String })
  first_name: string;

  @ApiProperty({ type: String })
  last_name: string;

  @ApiProperty({ type: String })
  bio: string;

  @ApiProperty({ type: String })
  username: string;

  @ApiProperty({ type: String })
  email: string;

  @ApiProperty({ type: String })
  phone_number: string;

  @ApiProperty({ type: Number })
  hourly_rate: number;

  @ApiProperty({ isArray: true, type: String })
  specializations: string[];

  @ApiProperty({ type: String, enum: GENDER })
  gender: GENDER;

  @ApiProperty({ type: Array<ROLES>, enum: ROLES })
  roles: Array<ROLES>;

  @ApiProperty({ type: Boolean })
  is_deleted: boolean;
}
