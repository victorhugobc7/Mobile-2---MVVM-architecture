import 'package:flutter/material.dart';
import '../resources/shared/app_coordinator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final coordinator = AppCoordinator();

    return MaterialApp(
      title: 'aplicativo massa',
      navigatorKey: coordinator.navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: coordinator.startApp(),
    );
  }
}