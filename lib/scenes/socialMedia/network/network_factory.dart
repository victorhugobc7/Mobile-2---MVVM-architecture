import 'package:flutter/material.dart';
import 'network_view_model.dart';
import 'network_view.dart';
import 'network_service.dart';
import '../../../resources/shared/app_coordinator.dart';

class NetworkFactory {
  static Widget make({required AppCoordinator coordinator, bool showBottomNav = true}) {
    final service = NetworkService();
    final viewModel = NetworkViewModel(coordinator: coordinator, service: service);
    return NetworkView(viewModel: viewModel, showBottomNav: showBottomNav);
  }
}
