import { PartialType } from '@nestjs/swagger';
import { CreateStressMonitorDto } from './create-stress-monitor.dto';

export class UpdateStressMonitorDto extends PartialType(CreateStressMonitorDto) {}
