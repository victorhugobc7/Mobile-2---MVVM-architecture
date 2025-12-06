import 'package:flutter/material.dart';
import '../../shared/colors.dart';
import '../../shared/styles.dart';
import '../../shared/spacing.dart';
import 'skill_chip_view_model.dart';

class SkillChip extends StatelessWidget {
  final SkillChipViewModel viewModel;

  const SkillChip._({required this.viewModel});

  static Widget instantiate({required SkillChipViewModel viewModel}) {
    return SkillChip._(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = viewModel.backgroundColor ?? blue_100;
    final txtColor = viewModel.textColor ?? blue_600;

    return GestureDetector(
      onTap: viewModel.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: extraSmall, vertical: tripleXS + 2),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              viewModel.text,
              style: label2Regular.copyWith(color: txtColor),
            ),
            if (viewModel.onRemove != null) ...[
              SizedBox(width: tripleXS),
              GestureDetector(
                onTap: viewModel.onRemove,
                child: Icon(
                  Icons.close,
                  size: 14,
                  color: txtColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
