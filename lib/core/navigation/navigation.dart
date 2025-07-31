import 'package:flutter/material.dart';
import '../../feature/motivation/presentation/screen/home/home_screen.dart';

class RouteNavigation {
  static const String homeScreen = "homeScreen";
  static const String settingsScreen = "settingsScreen";
}

class MyRoute {
  static Route<dynamic> generateRoute(RouteSettings rs) {
    switch (rs.name) {
      case RouteNavigation.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${rs.name}')),
          ),
        );
    }
  }
}
