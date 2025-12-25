import 'package:get/get.dart';
import '../api/comment_api.dart';
import '../models/comment_model.dart';

class CommentController extends GetxController {
  final comments = <CommentModel>[].obs;
  final isLoading = false.obs;
  final count = 0.obs;

  /// Initialize count from backend
  void initCount(int initialCount) {
    count.value = initialCount;
  }

  /// Load comments from API
  Future<void> loadComments(String videoId) async {
    isLoading.value = true;
    try {
      final result = await CommentApi.getComments(videoId);
      comments.assignAll(result);
      count.value = result.length;
    } finally {
      isLoading.value = false;
    }
  }

  /// Add a new comment
  Future<void> addComment({
    required String videoId,
    required String userId,
    required String content,
  }) async {
    await CommentApi.addComment(
      videoId: videoId,
      userId: userId,
      content: content,
    );

    // Update UI immediately
    await loadComments(videoId);
  }

  /// Update an existing comment
  Future<void> updateComment({
    required String videoId,
    required String commentId,
    required String newContent,
  }) async {
    await CommentApi.updateComment(
      videoId: videoId,
      commentId: commentId,
      content: newContent,
    );
    await loadComments(videoId);
  }

  /// Delete a comment
  Future<void> deleteComment({
    required String videoId,
    required String commentId,
  }) async {
    await CommentApi.deleteComment(videoId: videoId,commentId:  commentId);
    await loadComments(videoId);
  }
}
