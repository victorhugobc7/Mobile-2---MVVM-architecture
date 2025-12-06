import 'package:flutter/material.dart';
import 'switch_button_viewmodel.dart';
import '../../shared/styles.dart';
import '../../shared/colors.dart';
import '../../shared/spacing.dart';

class SwitchButton extends StatelessWidget {
  final SwitchButtonViewModel viewModel;

  const SwitchButton._({required this.viewModel});

  static Widget instantiate({required SwitchButtonViewModel viewModel}) {
    return SwitchButton._(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (viewModel.title != null)
          Text(viewModel.title!, style: labelTextStyle),
        _buildSwitchWithLabels(),
      ],
    );
  }

  Widget _buildSwitchWithLabels() {
    if (viewModel.showLabels) {
      // "With Text" variant - labels outside
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            viewModel.offLabel,
            style: label2Regular.copyWith(
              color: viewModel.value ? gray_600 : primaryInk,
              fontWeight: viewModel.value ? FontWeight.normal : FontWeight.w600,
            ),
          ),
          SizedBox(width: doubleXS),
          _buildSwitch(showInlineLabel: false),
          SizedBox(width: doubleXS),
          Text(
            viewModel.onLabel,
            style: label2Regular.copyWith(
              color: viewModel.value ? primaryInk : gray_600,
              fontWeight: viewModel.value ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      );
    }

    // "No Text" variant - label inside track
    return _buildSwitch(showInlineLabel: viewModel.showInlineLabel);
  }

  Widget _buildSwitch({required bool showInlineLabel}) {
    return GestureDetector(
      onTap: () => viewModel.onChanged(!viewModel.value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: showInlineLabel ? 56 : 44,
        height: 28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: viewModel.value ? blue_500 : gray_400,
        ),
        child: Stack(
          children: [
            // Inline label
            if (showInlineLabel)
              Positioned(
                left: viewModel.value ? 8 : null,
                right: viewModel.value ? null : 8,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Text(
                    viewModel.value ? viewModel.onLabel : viewModel.offLabel,
                    style: label2Regular.copyWith(
                      color: white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            // Thumb
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              left: viewModel.value ? (showInlineLabel ? 30 : 18) : 2,
              top: 2,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
