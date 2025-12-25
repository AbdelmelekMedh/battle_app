import 'package:battle_app/api/dio_api_helper.dart';
import 'package:battle_app/models/comment_model.dart';
import 'package:battle_app/services/shared_service.dart';
import 'package:dio/dio.dart';

class CommentApi {
  static Future<List<CommentModel>> getComments(String videoId) async {
    final res = await DioApiHelper.authorizedRequest(
          (token) => DioApiHelper.dio.get(
        'http://10.0.2.2:8080/api/comments/$videoId',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      ),
    );

    return (res.data as List)
        .map((e) => CommentModel.fromJson(e))
        .toList();
  }

  static Future<void> addComment({
    required String videoId,
    required String userId,
    required String content,
    String? parentId,
  }) async {
    await DioApiHelper.authorizedRequest(
          (token) => DioApiHelper.dio.post(
        'http://10.0.2.2:8080/api/comments/$videoId/addComment',
        queryParameters: {'userId': userId},
        data: {
          'content': content,
          'parentId': parentId,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      ),
    );
  }


  static Future<void> deleteComment({
    required String videoId,
    required String commentId,
  }) async {
    final details = await SharedService.loginDetails();
    await DioApiHelper.authorizedRequest(
          (token) => DioApiHelper.dio.delete(
        'http://10.0.2.2:8080/api/comments/$videoId/$commentId',
        queryParameters: {'userId': details!.id},
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      ),
    );
  }


  static Future<void> updateComment({
    required String videoId,
    required String commentId,
    required String content,
  }) async {
    final details = await SharedService.loginDetails();
    await DioApiHelper.authorizedRequest(
          (token) => DioApiHelper.dio.put(
        'http://10.0.2.2:8080/api/comments/$videoId/$commentId',
        queryParameters: {'userId': details!.id},
        data: {'content': content},
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      ),
    );
  }
}
