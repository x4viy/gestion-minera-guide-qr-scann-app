import 'package:logger/logger.dart';
import 'package:loadin_guide_scann/src/core/error/exceptions.dart';
import 'package:loadin_guide_scann/src/core/network/api_service.dart';
import 'package:loadin_guide_scann/src/core/utils/constants/network_constant.dart';
import 'package:loadin_guide_scann/src/features/auth/data/models/session_model.dart';
import 'package:loadin_guide_scann/src/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<Session?> currentUserSession();

  Future<Session> loginWithCiPassword({
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
  Future<Session> loginWithCiPassword({
    required String ci,
    required String password,
  }) async {
    try {
      final response = await _apiService.postData(
          getUserLoginPath(),
          {
            'numberIdentification': ci,
            'password': password,
          },
          null);
      if (response == null || response is! Map<String, dynamic>) {
        logger.e(
            '❌ Failed to login: Invalid response format or null response received.');
        throw ServerException(
            '❌ Invalid response format or null response received.', null);
      }
      logger.i('Login Response: $response');
      var session = Session.fromJson(response);
      session.user = UserModel(ci: ci);
      return session;
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
