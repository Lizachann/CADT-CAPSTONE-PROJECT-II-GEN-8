import { Module } from '@nestjs/common';
import { MindCheckupService } from './mind-checkup.service';
import { MindCheckupController } from './mind-checkup.controller';
import { HttpModule } from '@nestjs/axios';
import { MongooseModule } from '@nestjs/mongoose';
import {
  MindCheckup,
  MindCheckupSchema,
} from 'src/database/schemas/mind-checkup.schema';
import { Patient, PatientSchema } from 'src/database/schemas/patient.schema';

@Module({
  imports: [
    HttpModule,
    MongooseModule.forFeature([
      { name: MindCheckup.name, schema: MindCheckupSchema },
      { name: Patient.name, schema: PatientSchema },
    ]),
  ],
  controllers: [MindCheckupController],
  providers: [MindCheckupService],
})
export class MindCheckupModule {}
