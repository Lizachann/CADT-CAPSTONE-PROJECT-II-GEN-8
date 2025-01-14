import { IsOptional, IsString } from 'class-validator';

export class CommentQueryParam {
  @IsOptional()
  @IsString()
  post?: string;

  @IsOptional()
  @IsString()
  parent?: string;
}
