import 'package:flutter/material.dart';
import 'feed_view_model.dart';
import 'feed_view.dart';
import 'feed_service.dart';
import '../../../resources/shared/app_coordinator.dart';

class FeedFactory {
  static Widget make({required AppCoordinator coordinator}) {
    final service = FeedService();
    final viewModel = FeedViewModel(coordinator: coordinator, service: service);
    return FeedView(viewModel: viewModel);
  }
}
