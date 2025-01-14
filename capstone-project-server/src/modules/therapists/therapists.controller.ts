import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Query,
  UseInterceptors,
  UploadedFiles,
} from '@nestjs/common';
import { TherapistsService } from './therapists.service';
import { CreateTherapistDto } from './dto/create-therapist.dto';
import { UpdateTherapistDto } from './dto/update-therapist.dto';
import { ApiOkResponse, ApiQuery, ApiTags } from '@nestjs/swagger';
import { TherapistResponseDto } from './response/therapist-response.dto';
import { PaginationParamDto } from 'src/common/dto/pagination-param.dto';
import { TherapistRegistrationDto } from './dto/therapist-registration.dto';
import { FilesInterceptor } from '@nestjs/platform-express';
import {
  MAX_FILE_COUNT,
  TherapistApplicationPhotosPath,
} from 'src/constants/multer-file-constant';
import { multerOptions } from 'src/config/files/multer-file-options';
import { RelationalTherapistRegistrationResponse } from './response/relational-therapist-registration-response.dto';
import { UpdateTherapistRegistration } from './dto/update-therapist-registration.dto';

@ApiTags('Therapists')
@Controller('therapists')
export class TherapistsController {
  constructor(private readonly therapistsService: TherapistsService) {}

  @Post()
  create(@Body() createTherapistDto: CreateTherapistDto) {
    return this.therapistsService.create(createTherapistDto);
  }

  @Post('registration')
  @UseInterceptors(
    FilesInterceptor(
      'therapistApplicationPhotos',
      MAX_FILE_COUNT,
      multerOptions(TherapistApplicationPhotosPath),
    ),
  )
  therapistRegistration(
    @Body() therapistRegistrationDto: TherapistRegistrationDto,
    @UploadedFiles()
    files: Array<Express.Multer.File>,
  ) {
    return this.therapistsService.therapistRegistration(
      therapistRegistrationDto,
      files,
    );
  }

  @ApiOkResponse({
    type: RelationalTherapistRegistrationResponse,
    isArray: true,
  })
  @Get('registration')
  getAllTherapistRegistration() {
    return this.therapistsService.getAllTherapistRegistration();
  }

  @Patch('registration/:id')
  updateTherapistRegistration(
    @Param('id') id: string,
    @Body() updateTherpaistRegistration: UpdateTherapistRegistration,
  ) {
    return this.therapistsService.updateTherapistRegistration(
      id,
      updateTherpaistRegistration,
    );
  }

  @ApiOkResponse({ type: TherapistResponseDto, isArray: true })
  @Get()
  findAll(@Query() pagination: PaginationParamDto) {
    return this.therapistsService.findAll(pagination);
  }

  @ApiOkResponse({ type: String, isArray: true })
  @Get('specializations')
  getAllSpecializations() {
    return this.therapistsService.getAllSpecializations();
  }

  @ApiOkResponse({ type: TherapistResponseDto })
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.therapistsService.findOne(id);
  }

  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updateTherapistDto: UpdateTherapistDto,
  ) {
    return this.therapistsService.update(id, updateTherapistDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.therapistsService.remove(id);
  }
}
