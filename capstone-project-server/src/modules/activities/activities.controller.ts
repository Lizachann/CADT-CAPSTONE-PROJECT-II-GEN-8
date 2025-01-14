import { Controller, Get, Post, Body, Patch, Param, Delete, UseInterceptors, UploadedFiles } from '@nestjs/common';
import { ActivitiesService } from './activities.service';
import { CreateActivityDto } from './dto/create-activity.dto';
import { UpdateActivityDto } from './dto/update-activity.dto';
import { FilesInterceptor } from '@nestjs/platform-express';
import { AcitvitiesImagesPath, MAX_FILE_COUNT } from 'src/constants/multer-file-constant';
import { multerOptions } from 'src/config/files/multer-file-options';
import { ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { ActivityResponseDto } from './dto/response/activity-response.dto';

@ApiTags('activities')
@Controller('activities')
export class ActivitiesController {
  constructor(private readonly activitiesService: ActivitiesService) {}

  @Post()
  @UseInterceptors(
    FilesInterceptor(
      'activityImages',
      MAX_FILE_COUNT,
      multerOptions(AcitvitiesImagesPath),
    ),
  )
  create(
    @Body() createPostDto: CreateActivityDto,
    @UploadedFiles()
    files: Array<Express.Multer.File>,
  ) {
    return this.activitiesService.create(createPostDto, files);
  }

  @ApiOkResponse({ type: ActivityResponseDto, isArray: true})
  @Get()
  findAll() {
    return this.activitiesService.findAll();
  }

  @ApiOkResponse({ type: ActivityResponseDto })
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.activitiesService.findOne(id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateActivityDto: UpdateActivityDto) {
    return this.activitiesService.update(id, updateActivityDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.activitiesService.remove(id);
  }
}
