import 'package:flutter/material.dart';
import 'section_header_view_model.dart';
import '../../shared/colors.dart';
import '../../shared/styles.dart';
import '../../shared/spacing.dart';

class SectionHeader extends StatelessWidget {
  final SectionHeaderViewModel viewModel;

  const SectionHeader._({required this.viewModel});

  static Widget instantiate({required SectionHeaderViewModel viewModel}) {
    return SectionHeader._(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(small),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            viewModel.title,
            style: labelTextStyle.copyWith(color: primaryInk, fontSize: 16),
          ),
          if (viewModel.actionText != null)
            TextButton(
              onPressed: viewModel.onActionTapped,
              child: Text(
                viewModel.actionText!,
                style: label2Regular.copyWith(color: blue_500),
              ),
            ),
        ],
      ),
    );
  }
}
