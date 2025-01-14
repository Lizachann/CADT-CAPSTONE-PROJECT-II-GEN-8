import { Module } from '@nestjs/common';
import { StressMonitorService } from './stress-monitor.service';
import { StressMonitorController } from './stress-monitor.controller';
import { MongooseModule } from '@nestjs/mongoose';
import {
  StressMonitor,
  StressMonitorSchema,
} from 'src/database/schemas/stress-monitor.schema';
import { Patient, PatientSchema } from 'src/database/schemas/patient.schema';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: StressMonitor.name, schema: StressMonitorSchema },
      { name: Patient.name, schema: PatientSchema },
    ]),
  ],
  controllers: [StressMonitorController],
  providers: [StressMonitorService],
})
export class StressMonitorModule {}
