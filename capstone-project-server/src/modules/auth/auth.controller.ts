import { Controller, Get, Post, Body, Res, HttpCode, HttpStatus, Req } from '@nestjs/common';
import { AuthService } from './auth.service';
import { Request, Response } from 'express';
import { GetCurrentUserId, Public } from 'src/common/decorator';
import { LoginDto } from './dto/login.dto';
import { RegisterDto } from './dto/register.dto';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('Auth')
@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Public()
  @Post('patient/register')
  register(@Body() registerDto: RegisterDto, @Res({ passthrough: true }) response: Response) {
    return this.authService.patient_register(registerDto);
  }

  @Public()
  @Post('patient/login')
  patient_login(@Body() loginDto: LoginDto, @Res({ passthrough: true }) response: Response) {
    return this.authService.patient_login(loginDto, response);
  }

  @Get('patient/logout')
  @HttpCode(HttpStatus.OK)
  patient_logout(@GetCurrentUserId() id: string, @Req() request: Request, @Res({ passthrough: true }) response: Response) {
    console.log("touch controller")
    return this.authService.patient_logout(id, request, response);
  }
  
  @Public()
  @Post('admin/login')
  login(@Body() loginDto: LoginDto, @Res({ passthrough: true }) response: Response) {
    return this.authService.admin_login(loginDto, response);
  }

  @Get('admin/logout')
  @HttpCode(HttpStatus.OK)
  logout(@GetCurrentUserId() id: string, @Req() request: Request, @Res({ passthrough: true }) response: Response) {
    return this.authService.admin_logout(id, request, response);
  }

  @Public()
  @Get('refresh-token')
  refreshToken(@Req() request: Request,  @Res({ passthrough: true }) response: Response) {
    return this.authService.refreshToken(request,response);
  }
}
