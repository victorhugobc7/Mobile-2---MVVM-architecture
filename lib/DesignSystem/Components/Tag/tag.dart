import 'package:flutter/material.dart';
import '../../shared/styles.dart';
import '../../shared/spacing.dart';
import 'tag_view_model.dart';

class Tag extends StatelessWidget {
  final TagViewModel viewModel;

  const Tag._({required this.viewModel});

  static Widget instantiate({required TagViewModel viewModel}) {
    return Tag._(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: extraSmall, vertical: tripleXS),
      decoration: BoxDecoration(
        color: viewModel.color.withValues(alpha: viewModel.backgroundOpacity),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        viewModel.text,
        style: label2Regular.copyWith(
          color: viewModel.color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
