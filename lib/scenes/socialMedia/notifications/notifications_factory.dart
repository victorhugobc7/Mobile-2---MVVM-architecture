import 'package:flutter/material.dart';
import 'notifications_view_model.dart';
import 'notifications_view.dart';
import 'notifications_service.dart';
import '../../../resources/shared/app_coordinator.dart';

class NotificationsFactory {
  static Widget make({required AppCoordinator coordinator, bool showBottomNav = true}) {
    final service = NotificationsService();
    final viewModel = NotificationsViewModel(coordinator: coordinator, service: service);
    return NotificationsView(viewModel: viewModel, showBottomNav: showBottomNav);
  }
}
