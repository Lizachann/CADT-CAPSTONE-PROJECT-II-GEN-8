import { ApiProperty } from '@nestjs/swagger';
import { BaseResponse } from 'src/common/base-response.dto';

export class CreditReponseDto extends BaseResponse {
  @ApiProperty({ type: String })
  title: string;

  @ApiProperty({ type: Number })
  points: number;

  @ApiProperty({ type: Number })
  price: number;

  @ApiProperty({ type: Number })
  discount: number;

  @ApiProperty({ type: Boolean })
  is_visible: boolean;
}
