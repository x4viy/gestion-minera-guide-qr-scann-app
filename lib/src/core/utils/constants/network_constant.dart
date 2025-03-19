import 'package:flutter_dotenv/flutter_dotenv.dart';

final baseUrl = dotenv.get('BASE_URL');
const String userLoginPath = '/api/v1/login';

String getUserLoginPath() {
  return '$baseUrl$userLoginPath';
}

String getBaseUrl() {
  return baseUrl;
}

// String getArticlePath(int period) {
//   return "all-sections/${period.toString()}.json${getApiKeyPath()}";
// }
