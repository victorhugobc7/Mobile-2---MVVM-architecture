import 'package:flutter/material.dart';
import '../../resources/shared/app_coordinator.dart';

class HomeViewModel {
  final AppCoordinator coordinator;
  final String userName;
  final String userAddress;

  const HomeViewModel({
    required this.coordinator,
    required this.userName,
    required this.userAddress,
  });

  void goToJobPrediction() {
    coordinator.goToJobPrediction();
  }

  void goToSocialFeed() {
    coordinator.goToFeed();
  }

  void logout() {
    coordinator.goToLogin();
  }
}
