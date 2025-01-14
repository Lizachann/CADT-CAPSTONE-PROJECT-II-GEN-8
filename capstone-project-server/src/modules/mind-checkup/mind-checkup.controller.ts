import { Controller, Get, Post, Body, Param } from '@nestjs/common';
import { MindCheckupService } from './mind-checkup.service';
import { CreateMindCheckupDto } from './dto/create-mind-checkup.dto';
import { ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { CheckupCountResponseDto, MindCheckupResponseDto } from './response/mind-checkup-response.dto';

@ApiTags('Mind Checkup')
@Controller('mind-checkup')
export class MindCheckupController {
  constructor(private readonly mindCheckupService: MindCheckupService) {}

  @Post()
  create(@Body() createMindCheckupDto: CreateMindCheckupDto) {
    return this.mindCheckupService.create(createMindCheckupDto);
  }

  @ApiOkResponse({ type: MindCheckupResponseDto, isArray: true })
  @Get()
  findAll() {
    return this.mindCheckupService.findAll();
  }

  @ApiOkResponse({ type: MindCheckupResponseDto, isArray: true })
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.mindCheckupService.findOne(id);
  }

  @ApiOkResponse({ type: CheckupCountResponseDto })
  @Get('checkup-count/:id')
  findCheckupCount(@Param('id') id: string) {
    return this.mindCheckupService.findCheckupCount(id);
  }

  // @Patch(':id')
  // update(
  //   @Param('id') id: string,
  //   @Body() updateMindCheckupDto: UpdateMindCheckupDto,
  // ) {
  //   return this.mindCheckupService.update(+id, updateMindCheckupDto);
  // }

  // @Delete(':id')
  // remove(@Param('id') id: string) {
  //   return this.mindCheckupService.remove(+id);
  // }
}
