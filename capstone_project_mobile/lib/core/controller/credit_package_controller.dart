import 'package:capstone_project_mobile/core/model/credit_package.dart';
import 'package:capstone_project_mobile/core/services/get_service.dart';
import 'package:get/get.dart';

class CreditPackageController extends GetxController {
  final RxList<CreditPackage> allCreditPackages = <CreditPackage>[].obs;
  RxBool loading = false.obs;

  Future<void> fetchAllCreditPackages() async {
    loading.value = true;

    allCreditPackages.value =
        await GetService.fetchCreditPackages().then((value) {
      return value;
    }).catchError((err) => throw err);

    loading.value = false;
  }

  Future<List<CreditPackage>> getCreditPackages() async {
    await fetchAllCreditPackages();
    return allCreditPackages;
  }
}
