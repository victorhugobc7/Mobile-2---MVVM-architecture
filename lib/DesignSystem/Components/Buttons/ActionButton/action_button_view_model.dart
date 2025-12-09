import 'package:flutter/material.dart';

enum ActionButtonSize {
  small,
  medium,
  large
}

enum ActionButtonStyle {
  primary,
  secondary,
  tertiary,
  warning,
  negative,
  outline,
  outlineSuccess,
}

abstract class ActionButtonDelegate {
  void buttonClicked();
}

class ActionButtonViewModel {
  final ActionButtonSize size;
  final ActionButtonStyle style;
  final String text;
  final IconData? icon;
  final bool showIcon;
  final bool isExpanded;
  ActionButtonDelegate? delegate;

  ActionButtonViewModel({
    required this.size,
    required this.style,
    required this.text,
    this.delegate,
    this.icon,
    this.showIcon = false,
    this.isExpanded = false,
  });
}