import 'package:capstone_project_mobile/core/model/patient.dart';
import 'package:capstone_project_mobile/core/services/login_service.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var isLoading = false.obs;
  var user = Rxn<Patient>();

  Future register(String email, String password) async {
    isLoading(true);

    try {
      final response = await LoginService.register(email, password);
      // isLoggedIn(true);
      return response;
    } catch (e) {
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  void login(String email, String password) async {
    isLoading(true);

    try {
      final response = await LoginService.login(email, password);

      user.value = Patient.fromJson(response['patient']);

      isLoggedIn.value = true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to login');
    } finally {
      isLoading(false);
    }
  }

  void logout() {
    user.value = null;
    isLoggedIn.value = false;
  }
}
