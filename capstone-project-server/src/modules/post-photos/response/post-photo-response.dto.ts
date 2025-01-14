import { ApiProperty } from '@nestjs/swagger';
import { BaseResponse } from 'src/common/base-response.dto';
import { PostResponseDto } from 'src/modules/posts/response/post-response.dto';

export class PostPhotoResponseDto extends BaseResponse {
  @ApiProperty()
  filename: string;

  @ApiProperty({ type: PostResponseDto })
  post: string;
}
