import 'package:flutter_dotenv/flutter_dotenv.dart';

final String appName = dotenv.get('APP_NAME', fallback: "Mental Health App");
final String baseApiUrl = dotenv.get('BASE_API_URL', fallback: "10.0.2.2:8080");
