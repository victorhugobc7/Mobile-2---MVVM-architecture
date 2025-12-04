import 'package:flutter/material.dart';
import '../../../resources/shared/app_coordinator.dart';
import 'jobs_view_model.dart';
import 'jobs_view.dart';

class JobsFactory {
  static Widget make({required AppCoordinator coordinator}) {
    final viewModel = JobsViewModel(coordinator: coordinator);
    return JobsView(viewModel: viewModel);
  }
}
