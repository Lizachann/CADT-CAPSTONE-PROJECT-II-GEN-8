import { Module } from '@nestjs/common';
import { ActivityImagesService } from './activity-images.service';
import { ActivityImagesController } from './activity-images.controller';
import { MongooseModule } from '@nestjs/mongoose';
import { Activity, ActivitySchema } from 'src/database/schemas/activity.schema';
import { ActivityImages, ActivityImagesSchema } from 'src/database/schemas/activity-image.schema';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: Activity.name, schema: ActivitySchema },
      { name: ActivityImages.name, schema: ActivityImagesSchema },
    ]),
    ActivityImagesModule,
  ],
  controllers: [ActivityImagesController],
  providers: [ActivityImagesService],
  exports: [ActivityImagesService]
})
export class ActivityImagesModule {}
