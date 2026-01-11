import 'package:flutter/material.dart';
import '../../../resources/shared/app_coordinator.dart';
import '../feed/feed_factory.dart';
import '../network/network_factory.dart';
import '../notifications/notifications_factory.dart';
import '../jobs/jobs_factory.dart';
import 'main_shell_view.dart';
import 'main_shell_view_model.dart';

class MainShellFactory {
  static Widget make({required AppCoordinator coordinator}) {
    final pages = [
      FeedFactory.make(coordinator: coordinator, showBottomNav: false),
      NetworkFactory.make(coordinator: coordinator, showBottomNav: false),
      NotificationsFactory.make(coordinator: coordinator, showBottomNav: false),
      JobsFactory.make(coordinator: coordinator, showBottomNav: false),
    ];

    final viewModel = MainShellViewModel(
      coordinator: coordinator,
      pages: pages,
    );

    return MainShellView(viewModel: viewModel);
  }
}
