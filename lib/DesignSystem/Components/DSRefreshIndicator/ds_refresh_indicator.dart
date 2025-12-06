import 'package:flutter/material.dart';
import '../../shared/colors.dart';
import 'ds_refresh_indicator_view_model.dart';

class DSRefreshIndicator extends StatelessWidget {
  final DSRefreshIndicatorViewModel viewModel;

  const DSRefreshIndicator._({required this.viewModel});

  factory DSRefreshIndicator.instantiate({required DSRefreshIndicatorViewModel viewModel}) {
    return DSRefreshIndicator._(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: viewModel.onRefresh,
      color: blue_500,
      backgroundColor: white,
      displacement: viewModel.displacement,
      strokeWidth: viewModel.strokeWidth,
      child: viewModel.child,
    );
  }
}
