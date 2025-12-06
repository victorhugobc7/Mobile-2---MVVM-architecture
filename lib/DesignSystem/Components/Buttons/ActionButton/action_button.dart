import 'package:flutter/material.dart';
import 'action_button_view_model.dart';
import '../../../shared/colors.dart';
import '../../../shared/styles.dart';
import '../../../shared/spacing.dart';

class ActionButton extends StatefulWidget {
  final ActionButtonViewModel viewModel;

  const ActionButton._({required this.viewModel});

  static Widget instantiate({required ActionButtonViewModel viewModel}) {
    return ActionButton._(viewModel: viewModel);
  }

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  bool _isHovered = false;
  bool _isFocused = false;

  ActionButtonViewModel get viewModel => widget.viewModel;

  bool get _isHighlighted => _isHovered || _isFocused;

  @override
  Widget build(BuildContext context) {
    final isOutlineStyle = viewModel.style == ActionButtonStyle.outline || 
                           viewModel.style == ActionButtonStyle.outlineSuccess;
    final buttonColor = _getButtonColor();
    final hoverColor = _getHoverColor();
    final padding = _getPadding();

    // Filled buttons: darken on hover (blue_700)
    // Outline buttons: add 2px focus ring with gap
    final backgroundColor = isOutlineStyle 
        ? Colors.transparent 
        : (_isHighlighted ? hoverColor : buttonColor);
    final textColor = _getTextColor();

    Widget button;

    if (isOutlineStyle) {
      // Outline button with focus ring effect (2px gap + 2px border)
      button = MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Focus(
          onFocusChange: (focused) => setState(() => _isFocused = focused),
          child: Container(
            decoration: _isHighlighted
                ? BoxDecoration(
                    border: Border.all(color: buttonColor, width: 2),
                  )
                : null,
            padding: _isHighlighted ? const EdgeInsets.all(2) : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              decoration: BoxDecoration(
                color: backgroundColor,
                border: Border.all(color: buttonColor, width: 1),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: viewModel.onPressed,
                  child: Padding(
                    padding: padding,
                    child: _buildButtonContent(textColor),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      // Filled button - darkens on hover
      button = MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Focus(
          onFocusChange: (focused) => setState(() => _isFocused = focused),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              color: backgroundColor,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: viewModel.onPressed,
                child: Padding(
                  padding: padding,
                  child: _buildButtonContent(textColor),
                ),
              ),
            ),
          ),
        ),
      );
    }

    if (viewModel.isExpanded) {
      return SizedBox(
        width: double.infinity,
        child: button,
      );
    }

    return button;
  }

  Widget _buildButtonContent(Color textColor) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          viewModel.text.toUpperCase(),
          style: buttonStyle.copyWith(color: textColor),
        ),
        if (viewModel.showIcon && viewModel.icon != null) ...[
          SizedBox(width: doubleXS),
          Icon(
            viewModel.icon,
            size: 18,
            color: textColor,
          ),
        ],
      ],
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
      case ActionButtonStyle.outline:
        return blue_500;
      case ActionButtonStyle.outlineSuccess:
        return green_confirmation;
    }
  }

  Color _getHoverColor() {
    switch (viewModel.style) {
      case ActionButtonStyle.primary:
        return blue_700;
      case ActionButtonStyle.secondary:
        return const Color(0xff0D2D4D); // darker navy
      case ActionButtonStyle.tertiary:
        return const Color(0xff1F9997); // darker mint
      case ActionButtonStyle.warning:
        return const Color(0xffD4A017); // darker yellow
      case ActionButtonStyle.negative:
        return const Color(0xffB91C1C); // darker red
      case ActionButtonStyle.outline:
        return blue_700;
      case ActionButtonStyle.outlineSuccess:
        return const Color(0xff166534); // darker green
    }
  }

  Color _getTextColor() {
    switch (viewModel.style) {
      case ActionButtonStyle.warning:
        return primaryInk;
      case ActionButtonStyle.outline:
        return blue_500;
      case ActionButtonStyle.outlineSuccess:
        return green_confirmation;
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