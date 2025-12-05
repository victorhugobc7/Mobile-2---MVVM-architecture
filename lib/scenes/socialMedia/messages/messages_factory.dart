import 'package:flutter/material.dart';
import 'messages_view_model.dart';
import 'messages_view.dart';
import 'messages_service.dart';
import '../../../resources/shared/app_coordinator.dart';

class MessagesFactory {
  static Widget make({required AppCoordinator coordinator}) {
    final service = MessagesService();
    final viewModel = MessagesViewModel(coordinator: coordinator, service: service);
    return MessagesView(viewModel: viewModel);
  }
}
