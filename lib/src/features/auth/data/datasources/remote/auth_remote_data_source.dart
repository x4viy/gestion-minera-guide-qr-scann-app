import 'package:logger/logger.dart';
import 'package:pedidos/src/core/error/exceptions.dart';
import 'package:pedidos/src/core/network/api_service.dart';
import 'package:pedidos/src/core/utils/constants/network_constant.dart';
import 'package:pedidos/src/features/auth/data/models/session_model.dart';
import 'package:pedidos/src/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<Session?> currentUserSession();

  Future<UserModel> loginWithCiPassword({
    required String ci,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService _apiService;
  final Logger logger = Logger();
  AuthRemoteDataSourceImpl(this._apiService);

  @override
  Future<Session?> currentUserSession() async {
    // try {
    //   final response = await dio.post(getUserLoginPath());
    //   if (response.statusCode == 200) {
    //     return Session.fromJson(response.data);
    //   } else {
    //     logger.i('Failed to fetch session: ${response.statusCode}');
    //     return null;
    //   }
    // } catch (e) {
    //   logger.i('Error fetching session: $e');
    //   return null;
    // }
    throw UnimplementedError();
  }

  @override
  Future<UserModel> loginWithCiPassword({
    required String ci,
    required String password,
  }) async {
    try {
      return UserModel.fromJson({'login': 'admin', 'password': 'admin1977'});

      final response = await _apiService.postData(
          getUserLoginPath(),
          {
            'login': 'admin',
            'password': 'admin1977',
          },
          null);
      if (response == null || response is! Map<String, dynamic>) {
        logger.e(
            'Failed to login: Invalid response format or null response received.');
        throw ServerException(
            'Invalid response format or null response received.', null);
      }
      logger.i('Login Response: $response');
      return UserModel.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(e.message, e.statusCode);
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    //   try {
    //     if (currentUserSession != null) {
    //       final userData = await supabaseClient.from('profiles').select().eq(
    //             'id',
    //             currentUserSession!.user.id,
    //           );
    //       return UserModel.fromJson(userData.first).copyWith(
    //         ci: currentUserSession!.user.ci,
    //       );
    //     }

    //     return null;
    //   } catch (e) {
    //     throw ServerException(e.toString());
    //   }
    // }
    throw UnimplementedError();
  }
}
