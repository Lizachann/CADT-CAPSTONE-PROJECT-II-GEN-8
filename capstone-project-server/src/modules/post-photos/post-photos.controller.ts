import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseInterceptors,
  UploadedFiles,
} from '@nestjs/common';
import { PostPhotosService } from './post-photos.service';
import { UpdatePostPhotoDto } from './dto/update-post-photo.dto';
import { ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { FilesInterceptor } from '@nestjs/platform-express';
import {
  MAX_FILE_COUNT,
  PostPhotosPath,
} from 'src/constants/multer-file-constant';
import { multerOptions } from 'src/config/files/multer-file-options';
import { PostPhotoResponseDto } from './response/post-photo-response.dto';

@ApiTags('Post Photos')
@Controller('post-photos')
export class PostPhotosController {
  constructor(private readonly postPhotosService: PostPhotosService) {}

  @Post()
  @UseInterceptors(
    FilesInterceptor(
      'postPhotos',
      MAX_FILE_COUNT,
      multerOptions(PostPhotosPath),
    ),
  )
  create(
    @Body() id: string,
    @UploadedFiles() files: Array<Express.Multer.File>,
  ) {
    return this.postPhotosService.create(id, files);
  }

  @ApiOkResponse({ type: PostPhotoResponseDto })
  @Get()
  findAll() {
    return this.postPhotosService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.postPhotosService.findOne(+id);
  }

  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updatePostPhotoDto: UpdatePostPhotoDto,
  ) {
    return this.postPhotosService.update(+id, updatePostPhotoDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.postPhotosService.remove(+id);
  }
}
