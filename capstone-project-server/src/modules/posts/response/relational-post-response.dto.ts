import { PostPhotoResponseDto } from 'src/modules/post-photos/response/post-photo-response.dto';
import { PostResponseDto } from './post-response.dto';
import { ApiProperty } from '@nestjs/swagger';

export class RelationalPostResponseDto extends PostResponseDto {
  @ApiProperty({ type: PostPhotoResponseDto, isArray: true })
  postPhotos: Array<string>;
}
