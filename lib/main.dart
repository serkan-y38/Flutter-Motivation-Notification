import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motivation_notification/core/di/di_container.dart';
import 'package:motivation_notification/core/navigation/navigation.dart';
import 'package:motivation_notification/core/theme/theme.dart';
import 'package:motivation_notification/feature/motivation/presentation/bloc/motivation_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<MotivationBloc>(
          create: (context) => singleton(),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
