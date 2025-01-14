import { Module } from '@nestjs/common';
import { CredentialService } from './credential.service';
import { CredentialController } from './credential.controller';
import { Credential, CredentialSchema } from 'src/database/schemas/credential.schema';
import { Admin, AdminSchema } from 'src/database/schemas/admin.schema';
import { MongooseModule } from '@nestjs/mongoose';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: Credential.name, schema: CredentialSchema },
      { name: Admin.name, schema: AdminSchema },
    ]),
  ],
  controllers: [CredentialController],
  providers: [CredentialService],
})
export class CredentialModule {}
