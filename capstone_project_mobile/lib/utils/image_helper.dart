import 'package:capstone_project_mobile/constants/env_constants.dart';

class ImageHelper {
  final String imagePath;

  ImageHelper({
    required this.imagePath,
  });

  String getImage({required String filename}) {
    return "http://$baseApiUrl/$imagePath/$filename";
  }
}
