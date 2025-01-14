import 'package:capstone_project_mobile/core/controller/appointment_controller.dart';
import 'package:capstone_project_mobile/core/controller/therapist_controller.dart';
import 'package:get/get.dart';

class TherapistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TherapistController>(() => TherapistController());
    Get.lazyPut<AppointmentController>(() => AppointmentController());
  }
}
