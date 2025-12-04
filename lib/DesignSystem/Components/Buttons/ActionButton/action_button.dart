import 'package:flutter/material.dart';
import 'action_button_view_model.dart';
import '../../../shared/colors.dart';
import '../../../shared/styles.dart';
import '../../../shared/spacing.dart';

class ActionButton extends StatelessWidget {
  final ActionButtonViewModel viewModel;

  const ActionButton._({super.key, required this.viewModel});

  static Widget instantiate({required ActionButtonViewModel viewModel}) {
    return ActionButton._(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    final buttonColor = _getButtonColor();
    final textColor = _getTextColor();
    final padding = _getPadding();

    return ElevatedButton(
      onPressed: viewModel.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        padding: padding,
        elevation: 0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (viewModel.showIcon && viewModel.icon != null) ...[
            Icon(
              viewModel.icon,
              size: 18,
              color: textColor,
            ),
            SizedBox(width: doubleXS),
          ],
          Text(
            viewModel.text.toUpperCase(),
            style: buttonStyle.copyWith(color: textColor),
          ),
        ],
      ),
    );
  }

  Color _getButtonColor() {
    switch (viewModel.style) {
      case ActionButtonStyle.primary:
        return blue_500;
      case ActionButtonStyle.secondary:
        return navy_700;
      case ActionButtonStyle.tertiary:
        return mint_dark;
      case ActionButtonStyle.warning:
        return yellow_marigold;
      case ActionButtonStyle.negative:
        return red_error;
    }
  }

  Color _getTextColor() {
    switch (viewModel.style) {
      case ActionButtonStyle.warning:
        return primaryInk;
      default:
        return white;
    }
  }

  EdgeInsets _getPadding() {
    switch (viewModel.size) {
      case ActionButtonSize.large:
        return EdgeInsets.symmetric(horizontal: large, vertical: small);
      case ActionButtonSize.medium:
        return EdgeInsets.symmetric(horizontal: medium, vertical: extraSmall);
      case ActionButtonSize.small:
        return EdgeInsets.symmetric(horizontal: small, vertical: doubleXS);
    }
  }
}