import 'package:flutter/material.dart';
import '../../resources/shared/app_coordinator.dart';
import 'login_service.dart';

class LoginViewModel {
  final LoginService service;
  final AppCoordinator coordinator;
  const LoginViewModel({required this.service, required this.coordinator});

  AppCoordinator get appCoordinator => coordinator;

  Future<void> performLogin(
      String user,
      String password,
      {required void Function(String name, String address) onSuccess}) async {
    final response = await service.fetchLogin(user: user, password: password);

    final name = response["name"] as String? ?? "";
    final address = response["address"] as String? ?? "";

    onSuccess(name, address);
  }

  void presentHome(String name, String address) {
    coordinator.goToHome(name, address);
  }
}
