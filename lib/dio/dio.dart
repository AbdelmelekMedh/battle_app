import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: "http://10.0.2.2:8080/api",
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  )..interceptors.add(AuthInterceptor());
}

class AuthInterceptor extends Interceptor {
  final storage = const FlutterSecureStorage();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = await storage.read(key: "accessToken");

    if (token != null) {
      options.headers["Authorization"] = "Bearer $token";
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // expired or invalid token
    if (err.response?.statusCode == 401) {
      final refreshed = await _refreshToken();

      if (refreshed) {
        // retry request
        final accessToken = await storage.read(key: "accessToken");

        err.requestOptions.headers["Authorization"] = "Bearer $accessToken";

        final cloneReq = await ApiClient.dio.fetch(err.requestOptions);
        return handler.resolve(cloneReq);
      } else {
        // refresh token expired → logout
        await storage.deleteAll();
      }
    }

    return handler.next(err);
  }

  Future<bool> _refreshToken() async {
    try {
      String? refreshToken = await storage.read(key: "refreshToken");

      if (refreshToken == null) return false;

      final response = await ApiClient.dio.post(
        "/auth/refreshToken",
        data: {"refreshToken": refreshToken},
      );

      if (response.statusCode == 200) {
        final newAccess = response.data["accessToken"];
        final newRefresh = response.data["refreshToken"];

        await storage.write(key: "accessToken", value: newAccess);
        await storage.write(key: "refreshToken", value: newRefresh);

        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
