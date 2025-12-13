import 'package:battle_app/repository/profile_screen_data.dart';
import 'package:get/get.dart';
import '../api/profile_api.dart';
import '../models/profile_model.dart';
import '../services/shared_service.dart';

class ProfileController extends GetxController {
  final Rxn<ProfileScreenData> profileData = Rxn<ProfileScreenData>();
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    isLoading.value = true;

    final details = await SharedService.loginDetails();
    if (details == null) {
      isLoading.value = false;
      return;
    }

    await ProfileApi.createProfile();
    final profile = await ProfileApi.getProfile();

    profileData.value = ProfileScreenData(details, profile);
    isLoading.value = false;
  }

  Future<bool> updateProfile(
      ProfileModel updatedProfile,
      dynamic pickedImage,
      ) async {
    final success = await ProfileApi.updateProfileWithImage(
      updatedProfile,
      pickedImage,
    );

    if (success) {
      await loadProfile(); // 🔥 auto refresh everywhere
    }

    return success;
  }
}
