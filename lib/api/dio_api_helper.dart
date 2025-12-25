import 'package:dio/dio.dart';
import 'package:battle_app/services/shared_service.dart';
import 'package:battle_app/api/auth_api.dart';
import 'package:battle_app/main.dart';

class DioApiHelper {
  static final Dio dio = Dio();

  static Future<Response<T>> authorizedRequest<T>(
      Future<Response<T>> Function(String token) requestFunction,
      ) async {
    final details = await SharedService.loginDetails();
    if (details == null) {
      throw Exception("User not logged in");
    }

    try {
      return await requestFunction(details.token);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        final refreshed = await AuthApi.refreshToken();

        if (!refreshed) {
          await SharedService.setLoginDetails(null);
          navigatorKey.currentState
              ?.pushNamedAndRemoveUntil('/', (route) => false);
          throw Exception("Session expired");
        }

        final newDetails = await SharedService.loginDetails();
        return await requestFunction(newDetails!.token);
      }
      rethrow;
    }
  }
}
