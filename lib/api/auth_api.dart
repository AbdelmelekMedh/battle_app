import 'dart:convert';

import 'package:battle_app/services/shared_service.dart';
import 'package:http/http.dart' as http;

class AuthApi {

  static Future<http.Response> signUp(String username, String email, String password) {
    return http.post(
      Uri.parse("http://10.0.2.2:8080/api/auth/signup"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );
  }

  static Future<http.Response> signIn(String username, String password) {
    return http.post(
      Uri.parse("http://10.0.2.2:8080/api/auth/signin"),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: json.encode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
  }

  static Future<bool> refreshToken() async {
    final details = await SharedService.loginDetails();
    if (details == null) return false;

    final res = await http.post(
      Uri.parse("http://10.0.2.2:8080/api/auth/refreshToken"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"refreshToken": details.refreshToken}),
    );

    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      details.token = json["accessToken"];
      details.refreshToken = json["refreshToken"];

      await SharedService.setLoginDetails(details);
      return true;
    }

    return false;
  }

  static Future<http.Response> logout(String userId) {
    return http.post(
      Uri.parse("http://10.0.2.2:8080/api/auth/logout"),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: json.encode(<String, String>{
        'userId': userId,
      }),
    );
  }
}
