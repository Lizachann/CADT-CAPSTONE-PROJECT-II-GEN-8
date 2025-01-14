import 'package:capstone_project_mobile/constants/api_route_constant.dart';
import 'package:capstone_project_mobile/core/model/register_response.dart';
import 'package:capstone_project_mobile/core/services/http_service.dart';
import 'package:capstone_project_mobile/utils/api_helper.dart';

class LoginService {
  static Future register(String email, String password) async {
    HttpService httpService = HttpService(path: ApiRoute.registerPatient.name);

    var HttpResponse(:httpRes, :jsonData) = await httpService.httpPost(
      body: {'email': email, 'password': password},
    );

    if (ApiHelper.isOk(httpRes.statusCode)) {
      RegisterResponse registerResponse =
          RegisterResponse.fromJson(jsonData['data']['user']);

      return registerResponse;
    } else {
      throw jsonData;
    }
  }

  static Future login(String email, String password) async {
    HttpService httpService = HttpService(path: ApiRoute.login.name);

    var HttpResponse(:httpRes, :jsonData) = await httpService.httpPost(
      body: {'email': email, 'password': password},
    );

    if (ApiHelper.isOk(httpRes.statusCode)) {
      return jsonData['data'];
    } else {
      throw jsonData;
    }
  }

  Future<void> logout() async {
    // Implement logout logic if needed (e.g., token invalidation)
  }
}
