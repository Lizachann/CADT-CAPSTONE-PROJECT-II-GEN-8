import { Controller, Get, Post, Body, Patch, Param } from '@nestjs/common';
import { SavedPostsService } from './save-posts.service';
import { CreateSavedPostDto } from './dto/create-save-post.dto';
import { UpdateSavedPostDto } from './dto/update-save-post.dto';
import { ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { SavePostsResponseDto } from './response/save-posts-response.dto';

@ApiTags('Save posts')
@Controller('save-posts')
export class SavedPostsController {
  constructor(private readonly savedPostsService: SavedPostsService) {}

  @Post()
  create(@Body() createSavedPostDto: CreateSavedPostDto) {
    return this.savedPostsService.create(createSavedPostDto);
  }

  @ApiOkResponse({ type: SavePostsResponseDto, isArray: true })
  @Get()
  findAll() {
    return this.savedPostsService.findAll();
  }

  @ApiOkResponse({ type: SavePostsResponseDto })
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.savedPostsService.findOne(id);
  }

  @ApiOkResponse({ type: SavePostsResponseDto })
  @Get('patient-saved-posts/:id')
  findPatientSavePost(@Param('id') id: string) {
    return this.savedPostsService.findPatientSavedPosts(id);
  }

  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updateSavedPostDto: UpdateSavedPostDto,
  ) {
    return this.savedPostsService.update(id, updateSavedPostDto);
  }
}
