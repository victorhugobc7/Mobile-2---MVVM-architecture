import 'package:flutter/material.dart';
import '../../scenes/login/login_factory.dart';
import '../../scenes/home/home_factory.dart';
import '../../scenes/jobPrediction/job_prediction_factory.dart';

class AppCoordinator {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => navigatorKey.currentState;

  Widget startApp() {
    return goToLogin();
  }

  Widget goToLogin() {
    return LoginFactory.make(coordinator: this);
  }

  void goToHome(String name, String address) {
    _navigator?.push(
      MaterialPageRoute(
        builder: (_) => HomeFactory.make(
          coordinator: this,
          userName: name,
          userAddress: address,
        ),
      ),
    );
  }

  void goToJobPrediction() {
    _navigator?.push(
      MaterialPageRoute(
        builder: (_) => JobPredictionFactory.make(coordinator: this),
      ),
    );
  }

  void pop() {
    _navigator?.pop();
  }
}