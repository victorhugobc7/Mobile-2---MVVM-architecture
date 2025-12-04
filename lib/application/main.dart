import 'package:flutter/material.dart';
import '../resources/shared/app_coordinator.dart';

//FICAM NA PASTA application
void main() {
  final coordinator = AppCoordinator();
  runApp(Application(coordinator: coordinator));
}

class Application extends StatelessWidget {
  final AppCoordinator coordinator;
  const Application({super.key, required this.coordinator});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "MVVC Sample",
        navigatorKey: coordinator.navigatorKey,
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
        home: coordinator.startApp());
  }
}