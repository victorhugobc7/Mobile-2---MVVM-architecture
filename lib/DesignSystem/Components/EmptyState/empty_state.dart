import 'package:flutter/material.dart';
import '../../shared/colors.dart';
import '../../shared/styles.dart';
import '../../shared/spacing.dart';
import 'empty_state_view_model.dart';

class EmptyState extends StatelessWidget {
  final EmptyStateViewModel viewModel;

  const EmptyState._({required this.viewModel});

  static Widget instantiate({required EmptyStateViewModel viewModel}) {
    return EmptyState._(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(viewModel.icon, size: viewModel.iconSize, color: gray_400),
          SizedBox(height: small),
          Text(
            viewModel.title,
            style: labelTextStyle.copyWith(color: gray_600, fontSize: 18),
          ),
          SizedBox(height: doubleXS),
          Text(
            viewModel.subtitle,
            style: label2Regular.copyWith(color: gray_500),
          ),
        ],
      ),
    );
  }
}
