import {
  ForbiddenException,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { JwtService } from '@nestjs/jwt';
import { Response, Request } from 'express';
import { promisify } from 'util';
import * as crypto from 'crypto';
import { Admin, AdminDocument } from 'src/database/schemas/admin.schema';
import * as argon2 from 'argon2';
import {
  Credential,
  CredentialDocument,
} from 'src/database/schemas/credential.schema';
import { LoginDto } from './dto/login.dto';
import { RegisterDto } from './dto/register.dto';
import { Patient, PatientDocument } from 'src/database/schemas/patient.schema';
import { faker } from '@faker-js/faker';
import { PatientsService } from '../patients/patients.service';
import { getRandomGender, getRandomImage } from 'src/utils/helpter';

@Injectable()
export class AuthService {
  constructor(
    @InjectModel(Admin.name) private readonly adminModel: Model<AdminDocument>,
    @InjectModel(Patient.name)
    private readonly patientModel: Model<PatientDocument>,
    @InjectModel(Credential.name)
    private readonly credentialModel: Model<CredentialDocument>,
    private readonly jwtService: JwtService,
    private readonly patientService: PatientsService,
  ) {}

  // Generate reset password token
  async generateToken(): Promise<string> {
    const randomBytesAsync = promisify(crypto.randomBytes);
    try {
      const buffer = await randomBytesAsync(48);
      return buffer.toString('hex');
    } catch (error) {
      throw new Error('Token generation failed');
    }
  }

  async getTokens(id: string, email: string) {
    const payload = {
      id,
      email,
    };
    const [at, rt] = await Promise.all([
      this.jwtService.signAsync(payload, {
        secret: process.env.ACCESS_TOKEN_SECRET,
        expiresIn: '300s',
      }),
      this.jwtService.signAsync(payload, {
        secret: process.env.REFRESH_TOKEN_SECRET,
        expiresIn: '1d',
      }),
    ]);

    return {
      accessToken: at,
      refreshToken: rt,
    };
  }

  async updateRt(id: string, rt: string) {
    await this.adminModel.updateOne({ _id: id }, { refresh_token: rt });
  }

  async patient_login(loginDto: LoginDto, response: Response) {
    console.log(loginDto);

    response.clearCookie('jwt', {
      httpOnly: true,
      sameSite: 'none',
      secure: true,
    });

    const { email, password } = loginDto;
    console.log('🚀 ~ AuthService ~ patient_login ~ loginDto:', loginDto);

    const credential = await this.credentialModel.findOne({ email });

    const patient = await this.patientModel
      .findOne({ credential: credential._id })
      .populate('credential');

    if (patient) {
      const matched = await argon2.verify(
        patient.credential.password,
        password,
      );

      if (!matched) {
        throw new UnauthorizedException({
          message: 'Incorrect Email or Password!',
        });
      }

      const { accessToken, refreshToken } = await this.getTokens(
        patient._id.toString(),
        patient.credential.email,
      );

      await this.updateRt(patient._id.toString(), refreshToken);

      response.cookie('jwt', refreshToken, {
        httpOnly: true,
        sameSite: 'none',
        secure: true,
        maxAge: 24 * 60 * 60 * 1000,
      });

      return {
        patient,
        accessToken,
      };
    }
    throw new UnauthorizedException({
      message: 'Incorrect Email or Password!',
    });
  }

  async admin_login(loginDto: LoginDto, response: Response) {
    response.clearCookie('jwt', {
      httpOnly: true,
      sameSite: 'none',
      secure: true,
    });

    const { email, password } = loginDto;

    const credential = await this.credentialModel.findOne({ email });

    if (!credential) {
      throw new UnauthorizedException({
        message: 'Incorrect Email or Password',
      });
    }

    const admin = await this.adminModel
      .findOne({ credential: credential._id })
      .populate('credential');

    if (admin) {
      const matched = await argon2.verify(admin.credential.password, password);

      if (!matched) {
        throw new UnauthorizedException({
          message: 'Incorrect Email or Password!',
        });
      }

      const { accessToken, refreshToken } = await this.getTokens(
        admin._id.toString(),
        admin.credential.email,
      );

      await this.updateRt(admin._id.toString(), refreshToken);

      response.cookie('jwt', refreshToken, {
        httpOnly: true,
        sameSite: 'none',
        secure: true,
        maxAge: 24 * 60 * 60 * 1000,
      });

      return {
        admin,
        accessToken,
      };
    }
    throw new UnauthorizedException({
      message: 'Incorrect Email or Password!',
    });
  }

  async patient_logout(id: string, request: Request, response: Response) {
    const cookies = request.cookies;
    if (cookies?.jwt) {
      response.clearCookie('jwt', {
        httpOnly: true,
        sameSite: 'none',
        secure: true,
      });
    }
    try {
      await this.patientModel.updateOne({ _id: id }, { refresh_token: null });
    } catch (error) {
      console.log(error);
    }

    return { true: Boolean, message: 'Logout successful!' };
  }

  async admin_logout(id: string, request: Request, response: Response) {
    const cookies = request.cookies;
    if (cookies?.jwt) {
      response.clearCookie('jwt', {
        httpOnly: true,
        sameSite: 'none',
        secure: true,
      });
    }
    try {
      await this.adminModel.updateOne({ _id: id }, { refresh_token: null });
    } catch (error) {
      console.log(error);
    }

    return true;
  }

  async refreshToken(request: Request, response: Response) {
    const cookies = request.cookies;
    if (!cookies?.jwt) throw new UnauthorizedException('Access Denied.');
    const refreshToken = cookies.jwt;
    const admin = await this.adminModel
      .findOne({ rt: refreshToken })
      .populate('credential');
    if (!admin) {
      throw new UnauthorizedException('Access Denied');
    }

    try {
      const payload = this.jwtService.verify(refreshToken, {
        secret: process.env.REFRESH_TOKEN_SECRET,
      });
      if (payload?.id !== admin._id.toString()) {
        throw new UnauthorizedException('Access Denied');
      }
    } catch (error) {
      await this.adminModel.updateOne({ _id: admin._id }, { rt: null });
      response.clearCookie('jwt', {
        httpOnly: true,
        sameSite: 'none',
        secure: true,
      });
      throw new UnauthorizedException('Access Denied');
    }

    const accessToken = await this.jwtService.signAsync(
      {
        id: admin._id.toString(),
        email: admin.credential.email,
      },
      {
        secret: process.env.ACCESS_TOKEN_SECRET,
        expiresIn: '300s',
      },
    );
    return { accessToken };
  }

  async patient_register(registerDto: RegisterDto) {
    // generate random username
    const patient_username = faker.internet.userName();

    // Hash the password using argon2
    registerDto.password = await argon2.hash(registerDto.password);

    // Check if email is already taken
    const existingCredential = await this.credentialModel.findOne({
      email: registerDto.email,
    });
    if (existingCredential) {
      throw new ForbiddenException({
        message: 'Email is already taken',
      });
    }

    // Create and save the Credential document
    const patientCredential = new this.credentialModel({
      email: registerDto.email,
      password: registerDto.password,
    });

    await patientCredential.save().catch((error) => {
      if (error?.code === 11000) {
        // MongoDB duplicate key error code
        throw new ForbiddenException({
          message: 'Phone number is already taken.',
        });
      }
    });

    const newPatient = await this.patientService.create({
      ...registerDto,
      username: registerDto?.username ?? patient_username, // optionally creates a username
      credential: patientCredential?._id.toString(),
      profile_img: registerDto.profile_img ?? getRandomImage(),
      gender: registerDto.gender ?? getRandomGender(),
      credits: 0,
    });

    return {
      user: newPatient,
      message: 'Patient Created Successfully.',
    };
  }
}
