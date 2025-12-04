import 'package:flutter/material.dart';
import 'filter_chip_view_model.dart';
import '../../shared/colors.dart';
import '../../shared/styles.dart';
import '../../shared/spacing.dart';

class StyledFilterChip extends StatelessWidget {
  final FilterChipViewModel viewModel;

  const StyledFilterChip._({required this.viewModel});

  static Widget instantiate({required FilterChipViewModel viewModel}) {
    return StyledFilterChip._(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(viewModel.label),
      selected: viewModel.isSelected,
      onSelected: viewModel.onSelected,
      backgroundColor: white,
      selectedColor: blue_100,
      labelStyle: paragraph2Medium.copyWith(
        color: viewModel.isSelected ? blue_600 : gray_600,
        fontWeight: viewModel.isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
      side: BorderSide(
        color: viewModel.isSelected ? blue_500 : gray_400,
      ),
      checkmarkColor: blue_600,
      showCheckmark: viewModel.showCheckmark,
      padding: EdgeInsets.symmetric(horizontal: doubleXS, vertical: tripleXS),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(small),
      ),
    );
  }
}
