import 'package:flutter/material.dart';
import '../../resources/shared/app_coordinator.dart';
import '../../DesignSystem/Components/InputField/input_text_view_model.dart';
import '../../DesignSystem/Components/Buttons/ActionButton/action_button_view_model.dart';
import 'login_service.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginService service;
  final AppCoordinator coordinator;
  
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Component ViewModels
  late final InputTextViewModel usernameViewModel = InputTextViewModel(
    controller: userController,
    placeholder: 'Enter your username',
    password: false,
    title: 'Username',
    hasTitle: true,
  );

  late final InputTextViewModel passwordViewModel = InputTextViewModel(
    controller: passwordController,
    placeholder: 'Enter your password',
    password: true,
    title: 'Password',
    hasTitle: true,
  );

  late final ActionButtonViewModel loginButtonViewModel = ActionButtonViewModel(
    size: ActionButtonSize.large,
    style: ActionButtonStyle.primary,
    text: 'Login',
    icon: Icons.login,
    onPressed: handleLogin,
  );

  LoginViewModel({required this.service, required this.coordinator});

  AppCoordinator get appCoordinator => coordinator;

  Future<void> handleLogin() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final response = await service.fetchLogin(
        user: userController.text,
        password: passwordController.text,
      );

      final name = response["name"] as String? ?? "";
      final address = response["address"] as String? ?? "";

      presentHome(name, address);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void presentHome(String name, String address) {
    coordinator.goToFeedFromLogin();
  }

  @override
  void dispose() {
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}