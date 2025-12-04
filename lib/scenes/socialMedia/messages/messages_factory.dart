import 'package:flutter/material.dart';
import 'messages_view_model.dart';
import 'messages_view.dart';
import '../../../resources/shared/app_coordinator.dart';

class MessagesFactory {
  static Widget make({required AppCoordinator coordinator}) {
    final viewModel = MessagesViewModel(coordinator: coordinator);
    return MessagesView(viewModel: viewModel);
  }
}
