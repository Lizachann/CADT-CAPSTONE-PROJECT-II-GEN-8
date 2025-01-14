import { ApiProperty } from '@nestjs/swagger';
import { BaseResponse } from 'src/common/base-response.dto';
import { GENDER } from 'src/constants/gender-constant';
import { ROLES } from 'src/constants/roles-constant';
import { CredentialResponseDto } from 'src/modules/credential/response/credential-response.dto';

export class PatientResponseDto extends BaseResponse {
  @ApiProperty({ type: String })
  email: string;

  @ApiProperty({ type: String })
  username: string;

  @ApiProperty({ type: String, enum: GENDER })
  gender: GENDER;

  @ApiProperty({ type: Number })
  credits: number;

  @ApiProperty({ type: ROLES, enum: ROLES, isArray: true })
  roles: Array<ROLES>;

  @ApiProperty({ type: Boolean, default: false })
  is_deleted: boolean;

  @ApiProperty({ type: Boolean, default: false })
  is_banned: boolean;

  @ApiProperty({ type: String })
  profile_img: string;

  @ApiProperty({ type: Number, default: 0 })
  stress_monitor_count: number;

  @ApiProperty({ type: Number, default: 0 })
  mind_checkup_count: number;

  @ApiProperty({ type: CredentialResponseDto })
  credential: CredentialResponseDto;
}
