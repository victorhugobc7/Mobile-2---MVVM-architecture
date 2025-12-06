import 'package:flutter/material.dart';

class SkillChipViewModel {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  SkillChipViewModel({
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.onTap,
    this.onRemove,
  });
}
