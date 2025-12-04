import 'package:flutter/material.dart';

enum TextButtonSize {
  large,
  small,
}

enum TextButtonVariant {
  text,
  caretRight,
  caretLeft,
  iconLeft,
}

class TextButtonViewModel {
  final String text;
  final TextButtonSize size;
  final TextButtonVariant variant;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool isEnabled;

  TextButtonViewModel({
    required this.text,
    required this.onPressed,
    this.size = TextButtonSize.large,
    this.variant = TextButtonVariant.text,
    this.icon,
    this.isEnabled = true,
  });
}
