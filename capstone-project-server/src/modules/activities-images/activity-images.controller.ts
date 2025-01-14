import { Controller, Get, Post, Body, Patch, Param, Delete, UseInterceptors, UploadedFiles } from '@nestjs/common';
import { ActivityImagesService } from './activity-images.service';
import { CreateActivityImageDto } from './dto/create-activity-image.dto';
import { UpdateActivityImageDto } from './dto/update-activity-image.dto';
import { FilesInterceptor } from '@nestjs/platform-express';
import { AcitvitiesImagesPath, MAX_FILE_COUNT } from 'src/constants/multer-file-constant';
import { multerOptions } from 'src/config/files/multer-file-options';

@Controller('activity-images')
export class ActivityImagesController {
  constructor(private readonly activityImagesService: ActivityImagesService) {}

  @Post()
  @UseInterceptors(
    FilesInterceptor(
      'activityImages',
      MAX_FILE_COUNT,
      multerOptions(AcitvitiesImagesPath),
    ),
  )
  create(
    @Body() id: string,
    @UploadedFiles() files: Array<Express.Multer.File>,
  ) {
    return this.activityImagesService.create(id, files);
  }

  @Get()
  findAll() {
    return this.activityImagesService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.activityImagesService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateActivityImageDto: UpdateActivityImageDto) {
    return this.activityImagesService.update(+id, updateActivityImageDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.activityImagesService.remove(+id);
  }
}
