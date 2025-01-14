import { ApiProperty } from '@nestjs/swagger';
import { PatientResponseDto } from './patient-response.dto';
import { PostResponseDto } from 'src/modules/posts/response/post-response.dto';

export class RelationalPatientResponseDto extends PatientResponseDto {
  @ApiProperty({ type: PostResponseDto, isArray: true })
  posts: Array<string>;
}
