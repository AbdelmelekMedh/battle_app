import 'package:battle_app/controllers/profile_controller.dart';
import 'package:battle_app/services/shared_service.dart';
import 'package:battle_app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../widgets/gradient_container.dart';
import '../widgets/profile_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Obx(() {
      if (controller.isLoading.value ||
          controller.profileData.value == null) {
        return const Scaffold(
          backgroundColor: Colors.black,
          body: Center(child: CircularProgressIndicator()),
        );
      }

      final userProfile = controller.profileData.value!;
      final imageUrl = userProfile.profile?.imageProfile?.filePathUrl != null
          ? 'http://10.0.2.2:8080${userProfile.profile!.imageProfile!.filePathUrl}'
          : 'https://via.placeholder.com/150';

      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: RapupAppBar(
          height: MediaQuery.of(context).size.height / 10,
          leading: const SizedBox.shrink(),
          center: Text(
            '@${userProfile.details.username}',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(
              FontAwesomeIcons.signOutAlt,
              color: Colors.black,
            ),
            onPressed: () {
              SharedService.logout();
            },
          ),
        ),
        body: Stack(
          children: [
            const GradientContainer(),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 80),
              child: Column(
                children: [
                  Row(
                    children: [
                      profileImage(imageUrl),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          bio(
                            context,
                            userProfile.profile?.name ?? '',
                            userProfile.profile?.bio ?? '',
                          ),
                          editProfileButton(
                            'Edit Profile',
                                () => Get.toNamed('/editProfile', arguments: controller.profileData.value),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // rest
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
