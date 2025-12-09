import 'dart:convert';
import 'package:http/http.dart' as http;

class LogoutApi {
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
