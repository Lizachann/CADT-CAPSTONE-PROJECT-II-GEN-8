import 'package:capstone_project_mobile/constants/status_constant.dart';
import 'package:capstone_project_mobile/core/model/appointment.dart';
import 'package:capstone_project_mobile/core/services/get_service.dart';
import 'package:get/get.dart';

class AppointmentController extends GetxController {
  final RxList<Appointment> allAppointments = <Appointment>[].obs;
  final Rx<Appointment?> singleAppointment = Rx<Appointment?>(null);
  RxBool loading = false.obs;

  Future<void> fetchAllAppointments() async {
    loading.value = true;

    allAppointments.value = await GetService.fetchAppointments().then((value) {
      return value;
    }).catchError((err) => throw err);

    loading.value = false;
  }

  Future<void> fetchCompletedAppointments() async {
    loading.value = true;

    allAppointments.value = await GetService.fetchAppointmentsWithQuery(
        {'status': StatusConstant.completed.name}).then((value) {
      return value;
    }).catchError((err) => throw err);

    loading.value = false;
  }

  Future<void> fetchOneAppointment(String appointmentId) async {
    loading.value = true;

    singleAppointment.value =
        await GetService.fetchOneAppointment(appointmentId).then((value) {
      return value;
    }).catchError((err) => throw err);

    loading.value = false;
  }

  Future<List<Appointment>> getAllAppointments() async {
    await fetchAllAppointments();
    return allAppointments;
  }

  Future<List<Appointment>> getCompletedAppointments() async {
    await fetchCompletedAppointments();
    return allAppointments;
  }

  Future<Appointment?> getSingleAppointment(String appointmentId) async {
    await fetchOneAppointment(appointmentId);
    return singleAppointment.value;
  }
}
