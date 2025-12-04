import 'package:flutter/material.dart';
import 'profile_view_model.dart';
import 'profile_view.dart';
import '../../../resources/shared/app_coordinator.dart';

class ProfileFactory {
  static Widget make({required AppCoordinator coordinator}) {
    final viewModel = ProfileViewModel(coordinator: coordinator);
    return ProfileView(viewModel: viewModel);
  }
}
