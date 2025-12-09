import 'package:battle_app/services/shared_service.dart';
import 'package:flutter/material.dart';

import 'common/route_generator.dart';

String path = '/';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool reslt = await SharedService.isLoggedIn();
  if (reslt){
    path = '/home';
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Battle IU',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      initialRoute: path,
      onGenerateRoute: RouteGenerator.generateRoute,

    );
  }
}

