import 'package:flutter/material.dart';
import 'create_post_view_model.dart';
import 'create_post_view.dart';
import 'create_post_service.dart';
import '../../../resources/shared/app_coordinator.dart';

class CreatePostFactory {
  static Widget make({required AppCoordinator coordinator}) {
    final service = CreatePostService();
    final viewModel = CreatePostViewModel(coordinator: coordinator, service: service);
    return CreatePostView(viewModel: viewModel);
  }
}
