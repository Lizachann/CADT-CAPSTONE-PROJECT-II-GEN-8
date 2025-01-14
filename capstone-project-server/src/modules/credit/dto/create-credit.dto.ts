import { ApiProperty } from '@nestjs/swagger';
import { IsBoolean, IsNumber, IsOptional, IsString } from 'class-validator';

export class CreateCreditDto {
  @ApiProperty({ uniqueItems: true })
  @IsString()
  title: string;

  @ApiProperty()
  @IsNumber()
  points: number;

  @ApiProperty()
  @IsNumber({ maxDecimalPlaces: 2 })
  price: number;

  @ApiProperty()
  @IsOptional()
  @IsNumber({ maxDecimalPlaces: 2 })
  discount?: number;

  @ApiProperty()
  @IsOptional()
  @IsBoolean()
  is_visible?: boolean;
}
