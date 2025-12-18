import 'package:battle_app/api/video_api.dart';
import 'package:get/get.dart';

class VideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(VideoApi(), permanent: true);
  }
}
