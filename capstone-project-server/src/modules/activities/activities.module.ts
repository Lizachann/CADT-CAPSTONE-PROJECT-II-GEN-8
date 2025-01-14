import { Module } from '@nestjs/common';
import { ActivitiesService } from './activities.service';
import { ActivitiesController } from './activities.controller';
import { MongooseModule } from '@nestjs/mongoose';
import { Activity, ActivitySchema } from 'src/database/schemas/activity.schema';
import { ActivityImages, ActivityImagesSchema } from 'src/database/schemas/activity-image.schema';
import { ActivityImagesModule } from '../activities-images/activity-images.module';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: Activity.name, schema: ActivitySchema },
      { name: ActivityImages.name, schema: ActivityImagesSchema },
    ]),
    ActivityImagesModule,
  ],
  controllers: [ActivitiesController],
  providers: [ActivitiesService],
})
export class ActivitiesModule {}
