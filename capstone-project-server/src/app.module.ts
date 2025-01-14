import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { ConfigModule } from '@nestjs/config';
import { DatabaseModule } from './config/database/database.module';
import { AdminsModule } from './modules/admins/admins.module';
import { PatientsModule } from './modules/patients/patients.module';
import { APP_INTERCEPTOR } from '@nestjs/core';
import { ResponseInterceptor } from './common/response.interceptor';
import { TherapistsModule } from './modules/therapists/therapists.module';
import { PostsModule } from './modules/posts/posts.module';
import { SeedsModule } from './modules/seeds/seeds.module';
import { FactoriesModule } from './modules/factories/factories.module';
import { EventsModule } from './config/web-socket/events.module';
import { AppointmentsModule } from './modules/appointments/appointments.module';
import { AuthModule } from './modules/auth/auth.module';
import { CredentialModule } from './modules/credential/credential.module';
import { PostPhotosModule } from './modules/post-photos/post-photos.module';
import { MulterModule } from '@nestjs/platform-express';
import { STATIC_FILE_DESTINATION } from './constants/multer-file-constant';
import { ServeStaticModule } from '@nestjs/serve-static';
import { LikePostsModule } from './modules/like-posts/like-posts.module';
import { ActivitiesModule } from './modules/activities/activities.module';
import { ActivityImagesModule } from './modules/activities-images/activity-images.module';
import { PatientCommentsModule } from './modules/patient-comments/patient-comments.module';
import { SavePostsModule } from './modules/save-posts/save-posts.module';
import { CreditModule } from './modules/credit/credits.module';
import { StripeModule } from './modules/stripe/stripe.module';
import { StressMonitorModule } from './modules/stress-monitor/stress-monitor.module';
import { MindCheckupModule } from './modules/mind-checkup/mind-checkup.module';
import { TherapistApplicationPhotosModule } from './modules/therapist-application-photos/therapist-application-photos.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    MulterModule.registerAsync({
      useFactory: () => ({
        dest: STATIC_FILE_DESTINATION,
      }),
    }),
    ServeStaticModule.forRoot({
      rootPath: STATIC_FILE_DESTINATION,
    }),
    DatabaseModule,
    AdminsModule,
    PatientsModule,
    TherapistsModule,
    PostsModule,
    SeedsModule,
    FactoriesModule,
    EventsModule,
    AppointmentsModule,
    AuthModule,
    CredentialModule,
    LikePostsModule,
    PostPhotosModule,
    ActivitiesModule,
    ActivityImagesModule,
    PatientCommentsModule,
    SavePostsModule,
    CreditModule,
    StripeModule,
    StressMonitorModule,
    MindCheckupModule,
    TherapistApplicationPhotosModule,
  ],
  controllers: [AppController],
  providers: [
    {
      provide: APP_INTERCEPTOR,
      useClass: ResponseInterceptor,
    },

    /** TODO: Handle Protected routes */
    // {
    //   provide: APP_GUARD,
    //   useClass: AtGuard,
    // },
  ],
})
export class AppModule {}
