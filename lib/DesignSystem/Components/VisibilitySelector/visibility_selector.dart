import 'package:flutter/material.dart';
import '../../shared/colors.dart';
import '../../shared/styles.dart';
import '../../shared/spacing.dart';
import 'visibility_selector_view_model.dart';

export 'visibility_selector_view_model.dart';

class VisibilitySelector extends StatelessWidget {
  final VisibilitySelectorViewModel viewModel;

  const VisibilitySelector._({required this.viewModel});

  factory VisibilitySelector.instantiate({
    required VisibilitySelectorViewModel viewModel,
  }) {
    return VisibilitySelector._(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: viewModel.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: doubleXS, vertical: tripleXS),
        decoration: BoxDecoration(
          border: Border.all(color: gray_400),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(viewModel.displayIcon, size: 14, color: gray_600),
            SizedBox(width: tripleXS),
            Text(
              viewModel.displayLabel,
              style: label2Regular.copyWith(color: gray_600),
            ),
            const Icon(Icons.arrow_drop_down, size: 16, color: gray_600),
          ],
        ),
      ),
    );
  }
}
