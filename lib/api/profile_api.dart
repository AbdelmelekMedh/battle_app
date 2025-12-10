import 'dart:convert';
import 'package:battle_app/api/api_helper.dart';
import 'package:battle_app/models/profile_model.dart';
import 'package:battle_app/services/shared_service.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

class ProfileApi {
  static Future<http.Response> createProfile() async {
    final details = await SharedService.loginDetails();
    return ApiHelper.authorizedRequest((token) {
      return http.post(
        Uri.parse("http://10.0.2.2:8080/api/profile"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          'userId': details?.id,
        }),
      );
    });
  }

  static Future<ProfileModel?> getProfile() async {
    final details = await SharedService.loginDetails();
    final response = await ApiHelper.authorizedRequest((token) {
      return http.get(
        Uri.parse("http://10.0.2.2:8080/api/profile/${details!.id}"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
    });

    if (response.statusCode == 200) {
      return ProfileModel.fromJson(jsonDecode(response.body));
    }

    return null;
  }

  static Future<bool> updateProfileWithImage(
      ProfileModel profile,
      XFile? imageFile,
      ) async {
    final details = await SharedService.loginDetails();
    final response = await ApiHelper.authorizedRequest((token) async {
      var request = http.MultipartRequest(
        "PUT",
        Uri.parse("http://10.0.2.2:8080/api/profile/${details!.id}"),
      );

      request.headers["Authorization"] = "Bearer $token";

      request.files.add(
        http.MultipartFile.fromString(
          'profile',
          jsonEncode(profile.toJson()),
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

      final streamed = await request.send();
      return http.Response.fromStream(streamed);
    });
    return response.statusCode == 200;
  }

  static Future<bool> deleteProfile() async {
    final details = await SharedService.loginDetails();
    if (details == null) return false;

    final url = "http://10.0.2.2:8080/api/profile/${details.id}";

    try {
      final response = await ApiHelper.authorizedRequest(
            (token) => http.delete(
          Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      return response.statusCode == 204; // deleted successfully
    } catch (e) {
      print("Delete profile failed: $e");
      return false;
    }
  }
}
