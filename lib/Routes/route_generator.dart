import 'package:battle_app/bindings/profile_binding.dart';
import 'package:battle_app/pages/Start_Screen.dart';
import 'package:get/get.dart';

import '../pages/edit_profile.dart';
import '../pages/friendProfile.dart';
import '../pages/home.dart';
import '../pages/map.dart';
import '../pages/sign_in.dart';
import '../pages/sign_up.dart';

class RouteGenerator {
  static final pages = [
    GetPage(name: '/', page: () => Start_Screen()),
    GetPage(name: '/signIn', page: () => SignIn()),
    GetPage(name: '/signUp', page: () => SignUp()),
    GetPage(name: '/home', page: () => Home(), binding: ProfileBinding(),),
    GetPage(name: '/friendProfile', page: () => FriendProfile()),
    GetPage(name: '/map', page: () => MapScreen()),
    GetPage(name: '/editProfile', page: () => EditProfile()),
  ];
}
