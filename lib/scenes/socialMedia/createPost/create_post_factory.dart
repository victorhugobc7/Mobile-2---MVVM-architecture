import 'package:flutter/material.dart';
import 'create_post_view_model.dart';
import 'create_post_view.dart';
import '../../../resources/shared/app_coordinator.dart';

class CreatePostFactory {
  static Widget make({required AppCoordinator coordinator}) {
    final viewModel = CreatePostViewModel(coordinator: coordinator);
    return CreatePostView(viewModel: viewModel);
  }
}
