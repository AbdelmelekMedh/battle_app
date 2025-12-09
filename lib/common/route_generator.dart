import 'package:battle_app/pages/Start_Screen.dart';
import 'package:flutter/material.dart';

import '../pages/edit_profile.dart';
import '../pages/friendProfile.dart';
import '../pages/home.dart';
import '../pages/map.dart';
import '../pages/profile.dart';
import '../pages/sign_in.dart';
import '../pages/sign_up.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Start_Screen());
      case '/signIn':
        return MaterialPageRoute(builder: (_) => SignIn());
      case '/signUp':
        return MaterialPageRoute(builder: (_) => SignUp());
      case '/home':
        return MaterialPageRoute(builder: (_) => Home());
      case '/friendProfile':
        return MaterialPageRoute(builder: (_) => FriendProfile());
      case '/map':
        return MaterialPageRoute(builder: (_) => MapScreen());
      case '/editProfile':
        if (args is ProfileScreenData) {
          return MaterialPageRoute(
            builder: (_) => EditProfile(userProfile: args),
          );
        }
        return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
