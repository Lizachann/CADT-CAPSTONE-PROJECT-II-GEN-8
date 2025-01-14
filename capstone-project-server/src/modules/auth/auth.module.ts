import { Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { JwtModule } from '@nestjs/jwt';
import { MongooseModule } from '@nestjs/mongoose';
import { Admin, AdminSchema } from 'src/database/schemas/admin.schema';
import { Credential, CredentialSchema } from 'src/database/schemas/credential.schema';
import { AtStrategy } from './strategy';
import { Patient, PatientSchema } from 'src/database/schemas/patient.schema';
import { PatientsModule } from '../patients/patients.module';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: Admin.name, schema: AdminSchema },
      { name: Patient.name, schema: PatientSchema },
      { name: Credential.name, schema: CredentialSchema },
    ]),
    JwtModule.register({}),
    PatientsModule,
  ],
  controllers: [AuthController],
  providers: [AuthService, AtStrategy],
  exports: [AuthService]
})
export class AuthModule {}
