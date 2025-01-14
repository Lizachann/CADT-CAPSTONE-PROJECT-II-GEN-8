import { Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { MongooseModule } from '@nestjs/mongoose';
import { MONGO_CONNECTION_STRING } from 'src/constants/env-constants';

@Module({
  imports: [
    MongooseModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: async (configService: ConfigService) => ({
        uri: configService.getOrThrow<string>(MONGO_CONNECTION_STRING),
      }),
      inject: [ConfigService],
    }),
  ],
})
export class DatabaseModule {}
