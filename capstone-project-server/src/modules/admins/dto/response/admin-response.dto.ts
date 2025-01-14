import { ApiProperty } from '@nestjs/swagger';
import { BaseResponse } from 'src/common/base-response.dto';
import { ROLES } from 'src/constants/roles-constant';

export class AdminResponseDto extends BaseResponse {
  @ApiProperty({ type: String })
  email: string;

  @ApiProperty({ type: String })
  phone_number: string;

  @ApiProperty({ type: ROLES, enum: ROLES, isArray: true })
  roles: Array<ROLES>;
}
