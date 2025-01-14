import { ApiProperty } from '@nestjs/swagger';
import { ObjectId } from 'mongoose';

export class BaseResponse {
  @ApiProperty({ type: String })
  _id: ObjectId;

  @ApiProperty()
  createdAt: Date;

  @ApiProperty()
  updatedAt: Date;
}
