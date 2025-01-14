class ApiHelper {
  static bool isOk(int? statusCode) {
    if (statusCode == null) return true;
    return statusCode >= 200 && statusCode <= 299;
  }
}
