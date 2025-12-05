import 'package:flutter/material.dart';
import 'profile_view_model.dart';
import 'profile_view.dart';
import 'profile_service.dart';
import '../../../resources/shared/app_coordinator.dart';

class ProfileFactory {
  static Widget make({required AppCoordinator coordinator}) {
    final service = ProfileService();
    final viewModel = ProfileViewModel(coordinator: coordinator, service: service);
    return ProfileView(viewModel: viewModel);
  }
}
