import 'dart:convert';
import 'package:http/http.dart' as http;

class SignUpApi {
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
}
