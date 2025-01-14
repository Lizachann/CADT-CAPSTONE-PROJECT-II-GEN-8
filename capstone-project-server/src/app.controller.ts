import { Controller, Get } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { ConfigService } from '@nestjs/config';
import { API_BASE_URL, ENV_MODE } from 'src/constants/env-constants';
@ApiTags('Index')
@Controller()
export class AppController {
  constructor(private readonly configService: ConfigService) {}

  @Get()
  index() {
    return {
      message: 'Hello! This is Capstone 2 API',
      env: this.configService.getOrThrow(ENV_MODE),
      baseUrl: this.configService.getOrThrow(API_BASE_URL),
    };
  }
}
