import { ApiProperty } from '@nestjs/swagger';
import { PatientCommentResponseDto } from './patient-comment-response.dto';

export class NestedPatientCommentResponseDto extends PatientCommentResponseDto {
  @ApiProperty({ type: PatientCommentResponseDto })
  parent: PatientCommentResponseDto;

  @ApiProperty({ type: String })
  post: string;
}
