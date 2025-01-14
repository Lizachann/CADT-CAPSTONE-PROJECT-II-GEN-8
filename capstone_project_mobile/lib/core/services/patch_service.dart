import 'package:capstone_project_mobile/constants/api_route_constant.dart';
import 'package:capstone_project_mobile/core/services/http_service.dart';
import 'package:capstone_project_mobile/utils/api_helper.dart';

class PatchService {
  static Future updatePatientCredit(String patientId, int credits) async {
    HttpService httpService =
        HttpService(path: '${ApiRoute.patients.name}/add-credits/$patientId');

    var HttpResponse(:httpRes, :jsonData) = await httpService.httpPatch(
      body: {'credits': credits},
    );

    if (ApiHelper.isOk(httpRes.statusCode)) {
      return httpRes;
    } else {
      throw jsonData;
    }
  }
}
