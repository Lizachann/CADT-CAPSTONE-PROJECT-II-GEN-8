import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from '@nestjs/common';
import { CreditsService } from './credits.service';
import { CreateCreditDto } from './dto/create-credit.dto';
import { UpdateCreditDto } from './dto/update-credit.dto';
import { ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { CreditReponseDto } from './dto/response/credit-response.dto';

@ApiTags('Credits')
@Controller('credits')
export class CreditsController {
  constructor(private readonly creditService: CreditsService) {}

  @Post()
  create(@Body() createCreditDto: CreateCreditDto) {
    return this.creditService.create(createCreditDto);
  }

  @ApiOkResponse({ type: CreditReponseDto, isArray: true })
  @Get()
  findAll() {
    return this.creditService.findAll();
  }

  @ApiOkResponse({ type: CreditReponseDto, isArray: true })
  @Get('all')
  getAllCredit() {
    return this.creditService.getAllCredit();
  }

  @ApiOkResponse({ type: CreditReponseDto })
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.creditService.findOne(id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateCreditDto: UpdateCreditDto) {
    return this.creditService.update(id, updateCreditDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.creditService.remove(id);
  }
}
