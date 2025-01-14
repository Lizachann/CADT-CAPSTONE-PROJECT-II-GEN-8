import { Controller, Get, Body, Patch, Param, Query } from '@nestjs/common';
import { LikePostsService } from './like-posts.service';
import { UpdateLikePostDto } from './dto/update-like-post.dto';
import { ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { LikePostResponseDto } from './dto/response/like-post-response.dto';
import { PaginationParamDto } from 'src/common/dto/pagination-param.dto';

@ApiTags('Like Posts')
@Controller('like-posts')
export class LikePostsController {
  constructor(private readonly likePostsService: LikePostsService) {}

  @ApiOkResponse({ type: LikePostResponseDto, isArray: true })
  @Get()
  findAll(@Query() pagination: PaginationParamDto) {
    return this.likePostsService.findAll(pagination);
  }

  @ApiOkResponse({ type: LikePostResponseDto, isArray: true })
  @Get('/by-post/:id')
  findLikePostByPost(@Param('id') id: string) {
    return this.likePostsService.findLikePostByPost(id);
  }

  @ApiOkResponse({ type: LikePostResponseDto, isArray: true })
  @Get('/by-patient/:id')
  findLikePostByPatient(@Param('id') id: string) {
    return this.likePostsService.findLikePostByPatient(id);
  }

  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updateLikePostDto: UpdateLikePostDto,
  ) {
    return this.likePostsService.update(id, updateLikePostDto);
  }
}
