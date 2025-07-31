import 'package:flutter/material.dart';
import 'package:motivation_notification/core/navigation/navigation.dart';
import 'package:motivation_notification/core/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Motivation Notification',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: MyRoute.generateRoute,
      initialRoute: RouteNavigation.homeScreen,
      theme: MediaQuery.of(context).platformBrightness == Brightness.dark
          ? darkTheme
          : lightTheme,
    );
  }
}
