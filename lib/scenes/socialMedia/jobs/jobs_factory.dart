import 'package:flutter/material.dart';
import '../../../resources/shared/app_coordinator.dart';
import 'jobs_view_model.dart';
import 'jobs_view.dart';
import 'jobs_service.dart';

class JobsFactory {
  static Widget make({required AppCoordinator coordinator, bool showBottomNav = true}) {
    final service = JobsService();
    final viewModel = JobsViewModel(coordinator: coordinator, service: service);
    return JobsView(viewModel: viewModel, showBottomNav: showBottomNav);
  }
}
