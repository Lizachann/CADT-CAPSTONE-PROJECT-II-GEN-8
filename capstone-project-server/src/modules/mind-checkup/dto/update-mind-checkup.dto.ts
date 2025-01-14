import { PartialType } from '@nestjs/swagger';
import { CreateMindCheckupDto } from './create-mind-checkup.dto';

export class UpdateMindCheckupDto extends PartialType(CreateMindCheckupDto) {}
