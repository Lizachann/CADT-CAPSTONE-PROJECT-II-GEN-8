import { ApiProperty, PartialType } from '@nestjs/swagger';
import { CreatePatientCommentDto } from './create-patient-comment.dto';
import { IsBoolean, IsOptional } from 'class-validator';

export class UpdatePatientCommentDto extends PartialType(
  CreatePatientCommentDto,
) {
  @ApiProperty({ type: Boolean, default: false })
  @IsBoolean()
  @IsOptional()
  is_deleted?: boolean;
}
