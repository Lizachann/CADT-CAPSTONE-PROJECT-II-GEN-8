import { ApiProperty, OmitType } from '@nestjs/swagger';
import { BaseResponse } from 'src/common/base-response.dto';
import { PatientResponseDto } from 'src/modules/patients/dto/response/patient-response.dto';

export class PatientCommentResponseDto extends BaseResponse {
  @ApiProperty()
  content: string;

  @ApiProperty({
    type: OmitType(PatientResponseDto, [
      'gender',
      'roles',
      'is_deleted',
      'is_banned',
      'createdAt',
      'updatedAt',
      'email',
    ] as const),
  })
  patient: Omit<
    PatientResponseDto,
    | 'phone_number'
    | 'gender'
    | 'roles'
    | 'is_deleted'
    | 'is_banned'
    | 'createdAt'
    | 'updatedAt'
    | 'email'
  >;

  @ApiProperty({ type: Boolean, default: false })
  is_deleted: boolean;

  @ApiProperty({ type: Number, default: 0 })
  reply_count: number;
}
