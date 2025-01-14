import { Module } from '@nestjs/common';
import { CreditsService } from './credits.service';
import { CreditsController } from './credits.controller';
import { MongooseModule } from '@nestjs/mongoose';
import { Credit, CreditSchema } from 'src/database/schemas/credit.schema';

@Module({
  imports: [
    MongooseModule.forFeature([{ name: Credit.name, schema: CreditSchema }]),
  ],
  controllers: [CreditsController],
  providers: [CreditsService],
})
export class CreditModule {}
