import 'package:battle_app/services/shared_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Routes/route_generator.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
String path = '/';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool result = await SharedService.isLoggedIn();
  if (result){
    path = '/home';
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Battle App',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      initialRoute: path,
      getPages: RouteGenerator.pages,
    );
  }
}

