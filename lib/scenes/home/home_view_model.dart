import 'package:flutter/material.dart';
import '../../resources/shared/app_coordinator.dart';
import '../../DesignSystem/Components/Buttons/ActionButton/action_button_view_model.dart';

class HomeViewModel implements ActionButtonDelegate {
  final AppCoordinator coordinator;
  final String userName;
  final String userAddress;

  late final ActionButtonViewModel logoutButtonViewModel = ActionButtonViewModel(
    size: ActionButtonSize.large,
    style: ActionButtonStyle.secondary,
    text: 'Logout',
    icon: Icons.exit_to_app,
  );

  HomeViewModel({
    required this.coordinator,
    required this.userName,
    required this.userAddress,
  }) {
    logoutButtonViewModel.delegate = this;
  }

  @override
  void buttonClicked() {
    logout();
  }

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
