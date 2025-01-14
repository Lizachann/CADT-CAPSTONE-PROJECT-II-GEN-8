import { Controller, Get, Post, Body, Param } from '@nestjs/common';
import { StressMonitorService } from './stress-monitor.service';
import { CreateStressMonitorDto } from './dto/create-stress-monitor.dto';
import { ApiOkResponse, ApiTags } from '@nestjs/swagger';
import {
  StressMonitorCountResponseDto,
  StressMonitorResponseDto,
} from './response/stress-monitor-response.dto';

@ApiTags('Stress monitor')
@Controller('stress-monitor')
export class StressMonitorController {
  constructor(private readonly stressMonitorService: StressMonitorService) {}

  @Post()
  create(@Body() createStressMonitorDto: CreateStressMonitorDto) {
    return this.stressMonitorService.create(createStressMonitorDto);
  }

  @ApiOkResponse({ type: StressMonitorResponseDto, isArray: true })
  @Get()
  findAll() {
    return this.stressMonitorService.findAll();
  }

  @ApiOkResponse({ type: StressMonitorResponseDto, isArray: true })
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.stressMonitorService.findOne(id);
  }

  @ApiOkResponse({ type: StressMonitorCountResponseDto })
  @Get('stress-monitor-count/:id')
  findStressMonitorCount(@Param('id') id: string) {
    return this.stressMonitorService.findStressMonitorCount(id);
  }

  // @Patch(':id')
  // update(@Param('id') id: string, @Body() updateStressMonitorDto: UpdateStressMonitorDto) {
  //   return this.stressMonitorService.update(+id, updateStressMonitorDto);
  // }

  // @Delete(':id')
  // remove(@Param('id') id: string) {
  //   return this.stressMonitorService.remove(+id);
  // }
}
