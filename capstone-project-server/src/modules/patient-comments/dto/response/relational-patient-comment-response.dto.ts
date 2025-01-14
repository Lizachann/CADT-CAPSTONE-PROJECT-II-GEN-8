import { ApiProperty } from '@nestjs/swagger';
import { NestedPatientCommentResponseDto } from './nested-patient-comment-response.dto';

export class RelationalPatientCommentResponseDto extends NestedPatientCommentResponseDto {
  @ApiProperty({ type: NestedPatientCommentResponseDto, isArray: true })
  children: Array<NestedPatientCommentResponseDto>;
}
