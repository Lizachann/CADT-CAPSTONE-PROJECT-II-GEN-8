import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Patient } from 'src/database/schemas/patient.schema';
import { Model } from 'mongoose';
import { Post } from 'src/database/schemas/post.schema';
import { seed } from 'src/utils/seeder-helpter';
import { PostSeeder } from 'src/database/seeders/post.seeder';
import { PatientComment } from 'src/database/schemas/patient-comment.schema';
import { PatientCommentSeeder } from 'src/database/seeders/patient-comment.seeder';
import { Admin } from 'src/database/schemas/admin.schema';
import { AdminSeeder } from 'src/database/seeders/admin-seeder';
import { AdminsService } from '../admins/admins.service';
import { AuthService } from '../auth/auth.service';
import { PatientCredSeeder } from 'src/database/seeders/patient-credential-seeder';

@Injectable()
export class SeedsService {
  constructor(
    @InjectModel(Patient.name) private patientsModel: Model<Patient>,
    @InjectModel(Post.name) private postsModel: Model<Post>,
    @InjectModel(PatientComment.name)
    private patientCommentsModel: Model<PatientComment>,
    @InjectModel(Admin.name) private adminModel: Model<Admin>,
    private readonly adminService: AdminsService,
    private readonly authService: AuthService,
  ) {}

  async create() {
    // seed patients
    PatientCredSeeder().forEach(async (patient) => {
      await this.authService.patient_register(patient)
    })
    // await seed({
    //   model: this.patientsModel,
    //   seedData: PatientSeeder(),
    // });

    // seed posts
    await seed({
      model: this.postsModel,
      seedData: PostSeeder(),
    });

    // seed comments
    await seed({
      model: this.patientCommentsModel,
      seedData: PatientCommentSeeder(),
    });

    // seed admins
    AdminSeeder().forEach(
      async (admin) => await this.adminService.create(admin),
    );

    // other seed...

    return {
      message: 'Seeding Successful',
    };
  }
}
