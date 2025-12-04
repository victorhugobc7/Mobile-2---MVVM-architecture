import 'package:flutter/material.dart';
import 'home_view_model.dart';
import 'home_view.dart';
import '../../resources/shared/app_coordinator.dart';

class HomeFactory {
  static Widget make({
    required AppCoordinator coordinator,
    required String userName,
    required String userAddress,
  }) {
    final viewModel = HomeViewModel(
      coordinator: coordinator,
      userName: userName,
      userAddress: userAddress,
    );
    return HomeView(viewModel: viewModel);
  }
}
