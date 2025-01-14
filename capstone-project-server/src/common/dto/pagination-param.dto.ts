import { IsOptional, IsString } from 'class-validator';

export class PaginationParamDto {
  @IsString()
  @IsOptional()
  page?: number;

  @IsString()
  @IsOptional()
  limit?: number;
}
