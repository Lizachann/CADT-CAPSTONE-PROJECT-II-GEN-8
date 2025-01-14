import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Query,
} from '@nestjs/common';
import { PatientCommentsService } from './patient-comments.service';
import { CreatePatientCommentDto } from './dto/create-patient-comment.dto';
import { UpdatePatientCommentDto } from './dto/update-patient-comment.dto';
import { ApiOkResponse, ApiQuery, ApiTags } from '@nestjs/swagger';
import { RelationalPatientCommentResponseDto } from './dto/response/relational-patient-comment-response.dto';
import { CommentQueryParam } from './dto/comment-query-param';

@ApiTags('Patient Comments')
@Controller('patient-comments')
export class PatientCommentsController {
  constructor(
    private readonly patientCommentsService: PatientCommentsService,
  ) {}

  @Post()
  create(@Body() createPatientCommentDto: CreatePatientCommentDto) {
    return this.patientCommentsService.create(createPatientCommentDto);
  }

  @ApiOkResponse({ type: RelationalPatientCommentResponseDto, isArray: true })
  @Get('all')
  findAll() {
    return this.patientCommentsService.findAll();
  }

  @ApiOkResponse({ type: RelationalPatientCommentResponseDto, isArray: true })
  @ApiQuery({ name: 'comment', required: false })
  @ApiQuery({ name: 'post', required: false })
  @Get()
  findCommentByPost(@Query() commentQueryParam: CommentQueryParam) {
    return this.patientCommentsService.findCommentByPost(commentQueryParam);
  }

  @ApiOkResponse({ type: RelationalPatientCommentResponseDto, isArray: true })
  @Get('comments-new/:id')
  findCommentByPostV2(@Param('id') postId: string) {
    return this.patientCommentsService.findCommentByPostV2(postId);
  }

  @ApiOkResponse({ type: RelationalPatientCommentResponseDto })
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.patientCommentsService.findOne(id);
  }

  @Get('all-replies/:id')
  findAllReplies(@Param('id') id: string) {
    return this.patientCommentsService.findAllReplies(id);
  }

  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updatePatientCommentDto: UpdatePatientCommentDto,
  ) {
    return this.patientCommentsService.update(id, updatePatientCommentDto);
  }

  @Patch('remove-comment/:id')
  removePost(@Param('id') id: string) {
    return this.patientCommentsService.removeCommentV2(id);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.patientCommentsService.remove(id);
  }
}
