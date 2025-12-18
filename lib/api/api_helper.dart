import 'package:battle_app/main.dart';
import 'package:battle_app/services/shared_service.dart';
import 'package:battle_app/api/auth_api.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  static Future<http.Response> authorizedRequest(
      Future<http.Response> Function(String token) requestFunction,
      ) async {
    final details = await SharedService.loginDetails();
    if (details == null) {
      throw Exception("User not logged in");
    }

    // First attempt
    http.Response response = await requestFunction(details.token);

    // If token is expired → refresh
    if (response.statusCode == 401) {
      bool success = await AuthApi.refreshToken();

      if (!success) {
        // Token invalid → force logout
        await SharedService.setLoginDetails(null);
        navigatorKey.currentState?.pushNamedAndRemoveUntil('/', (route) => false);
        throw Exception("Session expired. Please login again.");
      }

      // Retry request with new token
      final newDetails = await SharedService.loginDetails();
      response = await requestFunction(newDetails!.token);
    }

    return response;
  }
}
