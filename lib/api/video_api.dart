import 'dart:convert';
import 'dart:io';

import 'package:battle_app/api/api_helper.dart';
import 'package:battle_app/models/video_model.dart';
import 'package:battle_app/services/shared_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../models/resource_file_stream_model.dart';

class VideoApi extends GetxService {
  static VideoApi get to => Get.find();

  final String baseUrl = "http://10.0.2.2:8080/api/video";


  Future<void> uploadFile({
    required File file,
    String? description,
    List<String>? tags,
  }) async {
    final details = await SharedService.loginDetails();

    await ApiHelper.authorizedRequest((token) async {
      final uri = Uri.parse("$baseUrl/upload");
      final request = http.MultipartRequest("POST", uri);

      request.headers["Authorization"] = "Bearer $token";
      request.fields["author_id"] = details!.id;

      if (description != null) request.fields["description"] = description;
      if (tags != null) {
        for (final tag in tags) {
          request.fields["tags"] = tag; // send each tag separately
        }
      }

      request.files.add(await http.MultipartFile.fromPath(
        "file",
        file.path,
        filename: basename(file.path),
      ));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode != 200) {
        throw Exception("File upload failed: ${response.body}");
      }

      return response;
    });
  }

  Future<void> updateFile({
    required String fileId,
    String? description,
    List<String>? tags,
    bool? isPublic,
  }) async {
    await ApiHelper.authorizedRequest((token) async {
      final uri = Uri.parse("$baseUrl/update/$fileId");
      final request = http.MultipartRequest("PUT", uri);

      request.headers["Authorization"] = "Bearer $token";

      if (description != null) request.fields["description"] = description;
      if (tags != null) {
        for (final tag in tags) {
          request.fields["tags"] = tag; // each tag separate
        }
      }
      if (isPublic != null) request.fields["isPublic"] = isPublic.toString();

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode != 200) {
        throw Exception("Update failed: ${response.body}");
      }

      return response;
    });
  }

  Future<List<VideoModel>> fetchPublicVideos() async {
    final response = await http.get(
      Uri.parse('$baseUrl/public?limit=3'),
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => VideoModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load public videos: ${response.body}");
    }
  }

  Future<ResourceFileStreamModel> getById(String id) async {
    final response = await ApiHelper.authorizedRequest((token) {
      return http.get(
        Uri.parse("$baseUrl/$id"),
        headers: {"Authorization": "Bearer $token"},
      );
    });

    if (response.statusCode == 200) {
      return ResourceFileStreamModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load file: ${response.body}");
    }
  }

  Future<List<ResourceFileStreamModel>> getByAuthor(String authorId) async {
    final response = await ApiHelper.authorizedRequest((token) {
      return http.get(
        Uri.parse("$baseUrl/author?id=$authorId"),
        headers: {"Authorization": "Bearer $token"},
      );
    });

    if (response.statusCode == 200) {
      final List list = jsonDecode(response.body);
      return list.map((e) => ResourceFileStreamModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load files: ${response.body}");
    }
  }

  Future<List<ResourceFileStreamModel>> search(String keyword) async {
    final response = await ApiHelper.authorizedRequest((token) {
      return http.get(
        Uri.parse("$baseUrl/search?keyword=$keyword"),
        headers: {"Authorization": "Bearer $token"},
      );
    });

    if (response.statusCode == 200) {
      final List list = jsonDecode(response.body);
      return list.map((e) => ResourceFileStreamModel.fromJson(e)).toList();
    } else {
      throw Exception("Search failed: ${response.body}");
    }
  }

  String downloadUrl(String id) => "$baseUrl/download/$id";

  Future<void> deleteFile(String videoId) async {
    await ApiHelper.authorizedRequest((token) async {
      final response = await http.delete(
        Uri.parse("$baseUrl/delete/$videoId"),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode != 200) {
        throw Exception("Delete failed: ${response.body}");
      }

      return response;
    });
  }

  Future<List<ResourceFileStreamModel>> getFeed({
    int page = 0,
    int size = 10,
  }) async {
    final response = await ApiHelper.authorizedRequest((token) {
      return http.get(
        Uri.parse('$baseUrl/feed?page=$page&size=$size'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
    });

    // response is now http.Response, we parse it
    if (response.statusCode == 200) {
      final List list = json.decode(response.body);
      return list.map((e) => ResourceFileStreamModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load feed: ${response.body}');
    }
  }

}
