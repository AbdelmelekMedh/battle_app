import 'dart:convert';
import 'package:battle_app/models/profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

class ProfileApi {
  static Future<http.Response> createProfile(String token, String userId, DateTime createdAt) {
    return  http.post(
      Uri.parse("http://10.0.2.2:8080/api/profile"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonEncode(<String, String>{
        'userId': userId,
      }),
    );
  }

  static Future<ProfileModel?> getProfile(String token, String userId) async {
    final response = await http.get(
      Uri.parse("http://10.0.2.2:8080/api/profile/$userId"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    if (response.statusCode == 200) {
      return ProfileModel.fromJson(jsonDecode(response.body));
    }
    return null; // 404 or error
  }

  static Future<bool> updateProfileWithImage(
      String token,
      String userId,
      ProfileModel profile,
      XFile? imageFile,
      ) async {
    var url = Uri.parse("http://10.0.2.2:8080/api/profile/$userId");

    var request = http.MultipartRequest("PUT", url);
    request.headers['Authorization'] = "Bearer $token";

    final profileJson = jsonEncode(profile.toJson());
    request.files.add(
      http.MultipartFile.fromString(
        'profile',
        profileJson,
        contentType: MediaType('application', 'json'),
      ),
    );

    if (imageFile != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          "image",
          imageFile.path,
          filename: imageFile.name,
        ),
      );
    }

    var response = await request.send();

    return response.statusCode == 200;
  }


}
