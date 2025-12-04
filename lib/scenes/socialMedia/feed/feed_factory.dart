import 'package:flutter/material.dart';
import 'feed_view_model.dart';
import 'feed_view.dart';
import '../../../resources/shared/app_coordinator.dart';

class FeedFactory {
  static Widget make({required AppCoordinator coordinator}) {
    final viewModel = FeedViewModel(coordinator: coordinator);
    return FeedView(viewModel: viewModel);
  }
}
