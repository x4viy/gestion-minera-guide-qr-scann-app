const String baseUrl = "http://192.168.137.47:3000";
// the apikey needs to be on env file and added to gitignore / only for testing
const String apiKey = "";
const String userLoginPath = '/user/login';

String getUserLoginPath() {
  return '$baseUrl$userLoginPath';
}

String getBaseUrl() {
  return baseUrl;
}

String getApiKeyPath() {
  return "?api-key=$apiKey";
}

// String getArticlePath(int period) {
//   return "all-sections/${period.toString()}.json${getApiKeyPath()}";
// }

