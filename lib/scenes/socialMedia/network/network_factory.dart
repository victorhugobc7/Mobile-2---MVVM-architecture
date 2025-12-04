import 'package:flutter/material.dart';
import 'network_view_model.dart';
import 'network_view.dart';
import '../../../resources/shared/app_coordinator.dart';

class NetworkFactory {
  static Widget make({required AppCoordinator coordinator}) {
    final viewModel = NetworkViewModel(coordinator: coordinator);
    return NetworkView(viewModel: viewModel);
  }
}
