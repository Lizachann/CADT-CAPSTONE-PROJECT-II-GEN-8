import { ApiProperty } from '@nestjs/swagger';
import { BaseResponse } from 'src/common/base-response.dto';

export class CreatePostResponseDto extends BaseResponse {
  @ApiProperty({ type: String })
  body: string;

  @ApiProperty({ type: String })
  patient: string;

  @ApiProperty({ type: Number })
  like_count: number;

  @ApiProperty({ type: Number })
  comment_count: number;

  @ApiProperty({ type: Number })
  save_count: number;

  @ApiProperty({ type: Boolean, default: false })
  stress_result: boolean;
}
