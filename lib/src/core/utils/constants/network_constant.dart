import 'package:flutter_dotenv/flutter_dotenv.dart';

final baseUrl = dotenv.get('BASE_URL');
final sensorsPort = dotenv.get('SENSORS_PORT');
final backendPort = dotenv.get('BACKEND_PORT');

const String userLoginPath = '/api/v1/login';
const String selectGuide = '/select_guide';

String getBaseUrl() {
  return baseUrl;
}

String getUserLoginPath() {
  return '$baseUrl:$backendPort$userLoginPath';
}

String getSocketLoginPath() {
  return '$baseUrl:$sensorsPort$selectGuide';
}
