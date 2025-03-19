import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:loadin_guide_scann/src/core/error/exceptions.dart';
import 'package:loadin_guide_scann/src/core/utils/constants/network_constant.dart';

class ApiService<T> {
  // final _storage = LocalStorageRepositoryImplementation();
  final Logger logger = Logger();

  late final Dio _dio = Dio(
    BaseOptions(
      baseUrl: getBaseUrl(),
      headers: {'Content-Type': 'application/json'},
    ),
  )..interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) async {
        // final authToken = await _storage.getToken();
        // options.headers['Authorization'] = 'Bearer $authToken';
        options.headers['Authorization'] = 'Bearer';
        logger.i(options.uri);
        // logger.i('token $authToken');
        return handler.next(options);
      }),
    );

  Future<T> getData(String endPoint, Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters) async {
    try {
      var response = await _dio.get(
        endPoint,
        data: data,
        queryParameters: queryParameters,
      );
      if (response.statusCode == 200) {
        logger.i('Respuesta: ${response.data}');
        return response.data as T;
      }
    } on DioException catch (e, s) {
      logger.e('$s');
      bool hasResponse = e.response != null;
      throw ServerException(hasResponse ? "$e.response" : "No response",
          hasResponse ? e.response!.statusCode : null);
    }
    throw ServerException('Server error', null);
  }

  Future<T> postData(String endPoint, Map<String, dynamic> data,
      Map<String, dynamic>? queryParameters) async {
    try {
      var response = await _dio.post(endPoint,
          data: data, queryParameters: queryParameters);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is T) {
          return response.data as T;
        }
        return response.data;
      }
    } on DioException catch (e, s) {
      logger.e('$s');
      bool hasResponse = e.response != null;
      if (hasResponse && e.response?.data['message'] != null) {
        throw ServerException(
            e.response?.data['message'], e.response?.statusCode);
      }
      throw ServerException(
          hasResponse ? "$e.response" : "No response", e.response?.statusCode);
    }
    throw ServerException('Server error', null);
  }
}
