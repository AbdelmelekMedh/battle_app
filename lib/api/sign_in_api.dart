import 'dart:convert';
import 'package:http/http.dart' as http;

class SignInApi {
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
}
