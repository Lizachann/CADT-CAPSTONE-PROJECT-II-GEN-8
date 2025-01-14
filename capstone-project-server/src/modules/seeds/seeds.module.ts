import { Module } from '@nestjs/common';
import { SeedsService } from './seeds.service';
import { SeedsController } from './seeds.controller';
import { MongooseModule } from '@nestjs/mongoose';
import { Patient, PatientSchema } from 'src/database/schemas/patient.schema';
import { Post, PostSchema } from 'src/database/schemas/post.schema';
import {
  PatientComment,
  PatientCommentSchema,
} from 'src/database/schemas/patient-comment.schema';
import { Admin, AdminSchema } from 'src/database/schemas/admin.schema';
import { AdminsModule } from '../admins/admins.module';
import { AuthModule } from '../auth/auth.module';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: Patient.name, schema: PatientSchema },
      { name: Post.name, schema: PostSchema },
      { name: PatientComment.name, schema: PatientCommentSchema },
      { name: Admin.name, schema: AdminSchema },
    ]),
    AdminsModule,
    AuthModule,
  ],
  controllers: [SeedsController],
  providers: [SeedsService],
})
export class SeedsModule {}
