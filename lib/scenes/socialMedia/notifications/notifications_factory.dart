import 'package:flutter/material.dart';
import 'notifications_view_model.dart';
import 'notifications_view.dart';
import '../../../resources/shared/app_coordinator.dart';

class NotificationsFactory {
  static Widget make({required AppCoordinator coordinator}) {
    final viewModel = NotificationsViewModel(coordinator: coordinator);
    return NotificationsView(viewModel: viewModel);
  }
}
