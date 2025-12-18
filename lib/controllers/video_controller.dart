import 'package:get/get.dart';
import '../api/video_api.dart';
import '../models/resource_file_stream_model.dart';

class AudioVideoController extends GetxController {
  final VideoApi api = VideoApi.to;

  var files = <ResourceFileStreamModel>[].obs;
  var isLoading = false.obs;

  Future<void> loadByAuthor(String authorId) async {
    try {
      isLoading.value = true;
      files.value = await api.getByAuthor(authorId);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchFiles(String keyword) async {
    try {
      isLoading.value = true;
      files.value = await api.search(keyword);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> delete(String id) async {
    await api.deleteFile(id);
    files.removeWhere((e) => e.id == id);
  }
}
