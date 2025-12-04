import 'package:flutter/material.dart';
import 'job_prediction_service.dart';
import 'job_prediction_view_model.dart';
import 'job_prediction_view.dart';
import '../../resources/shared/app_coordinator.dart';

class JobPredictionFactory {
  static Widget make({required AppCoordinator coordinator}) {
    final service = JobPredictionService();
    final viewModel = JobPredictionViewModel(service: service, coordinator: coordinator);
    return JobPredictionView(viewModel: viewModel);
  }
}
