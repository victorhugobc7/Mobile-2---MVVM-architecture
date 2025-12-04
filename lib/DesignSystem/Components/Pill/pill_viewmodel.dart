import 'package:flutter/material.dart';

enum PillStyle {
  Primary, 
  Secondary, 
  Secondary_Light, 
  Gray, 
  Gray_Light, 
  Tertiary, 
  Tertiary_Light, 
  Positive, 
  Positive_Light, 
  Warning, 
  Warning_Light, 
  Negative, 
  Negative_Light
}

class PillViewModel {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  final PillStyle? style;

  PillViewModel({
    required this.style,
    required this.label,
    this.isSelected = false,
    this.onTap,
  });
}