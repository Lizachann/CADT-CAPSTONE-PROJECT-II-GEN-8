import { ApiProperty } from '@nestjs/swagger';
import { BaseResponse } from 'src/common/base-response.dto';
import { PostResponseDto } from 'src/modules/posts/response/post-response.dto';

export class SavePostsResponseDto extends BaseResponse {
  @ApiProperty({ type: String })
  patient: string;

  @ApiProperty({ type: PostResponseDto })
  post: PostResponseDto;

  @ApiProperty({ type: Boolean })
  is_saved: boolean;
}
