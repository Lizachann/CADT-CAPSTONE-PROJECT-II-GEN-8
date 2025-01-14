import { Controller, Get, Post, Body, Patch, Param, Delete, UploadedFiles, UseInterceptors } from '@nestjs/common';
import { TherapistApplicationPhotosService } from './therapist-application-photos.service';
import { CreateTherapistApplicationPhotoDto } from './dto/create-therapist-application-photo.dto';
import { UpdateTherapistApplicationPhotoDto } from './dto/update-therapist-application-photo.dto';
import { FilesInterceptor } from '@nestjs/platform-express';
import { MAX_FILE_COUNT, TherapistApplicationPhotosPath } from 'src/constants/multer-file-constant';
import { multerOptions } from 'src/config/files/multer-file-options';

@Controller('therapist-application-photos')
export class TherapistApplicationPhotosController {
  constructor(private readonly therapistApplicationPhotosService: TherapistApplicationPhotosService) {}


  @Post()
  @UseInterceptors(
    FilesInterceptor(
      'therapistApplicationPhotos',
      MAX_FILE_COUNT,
      multerOptions(TherapistApplicationPhotosPath),
    ),
  )
  create(
    @Body() id: string,
    @UploadedFiles() files: Array<Express.Multer.File>,
  ) {
    return this.therapistApplicationPhotosService.create(id, files);
  }

  @Get()
  findAll() {
    return this.therapistApplicationPhotosService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.therapistApplicationPhotosService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateTherapistApplicationPhotoDto: UpdateTherapistApplicationPhotoDto) {
    return this.therapistApplicationPhotosService.update(+id, updateTherapistApplicationPhotoDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.therapistApplicationPhotosService.remove(+id);
  }
}
