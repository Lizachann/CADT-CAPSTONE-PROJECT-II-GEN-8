import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Req,
  Query,
  UseInterceptors,
  UploadedFiles,
} from '@nestjs/common';
import { PostsService } from './posts.service';
import { CreatePostDto } from './dto/create-post.dto';
import { UpdatePostDto } from './dto/update-post.dto';
import { ApiHeader, ApiOkResponse, ApiQuery, ApiTags } from '@nestjs/swagger';
import { FilesInterceptor } from '@nestjs/platform-express';
import { multerOptions } from 'src/config/files/multer-file-options';
import {
  MAX_FILE_COUNT,
  PostPhotosPath,
} from 'src/constants/multer-file-constant';
import { RelationalPostResponseDto } from './response/relational-post-response.dto';
import { CreatePostResponseDto } from './response/create-post-response.dto';

@ApiTags('Posts')
@Controller('posts')
export class PostsController {
  constructor(private readonly postsService: PostsService) {}

  @ApiOkResponse({ type: CreatePostResponseDto })
  @Post()
  @UseInterceptors(
    FilesInterceptor(
      'postPhotos',
      MAX_FILE_COUNT,
      multerOptions(PostPhotosPath),
    ),
  )
  create(
    @Body() createPostDto: CreatePostDto,
    @UploadedFiles()
    files: Array<Express.Multer.File>,
  ) {
    return this.postsService.create(createPostDto, files);
  }

  @ApiOkResponse({ type: RelationalPostResponseDto, isArray: true })
  @Get()
  @ApiQuery({ name: 'page', type: Number, example: 1, required: false })
  @ApiQuery({ name: 'limit', type: Number, example: 10, required: false })
  findAll(@Query('page') page: number, @Query('limit') limit: number) {
    return this.postsService.findAll({ page, limit });
  }

  @ApiOkResponse({ type: RelationalPostResponseDto })
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.postsService.findOne(id);
  }

  @ApiOkResponse({ type: RelationalPostResponseDto, isArray: true })
  @Get('patient-post/:patientId')
  findPatientPost(@Param('patientId') id: string) {
    return this.postsService.findPatientPost(id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updatePostDto: UpdatePostDto) {
    return this.postsService.update(id, updatePostDto);
  }

  @ApiHeader({ name: 'patient_id', required: true })
  @Patch('/remove-post/:id')
  userRemovePost(@Req() request: Request, @Param('id') id: string) {
    const patient_id = request.headers['patient_id'];
    return this.postsService.userRemovePost(id, { patient_id });
  }

  @ApiHeader({ name: 'patient_id', required: true })
  @Delete(':id')
  remove(@Req() request: Request, @Param('id') id: string) {
    const patient_id = request.headers['patient_id'];
    return this.postsService.remove(id, { patient_id });
  }
}
