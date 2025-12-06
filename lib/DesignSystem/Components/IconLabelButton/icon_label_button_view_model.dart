import 'package:flutter/material.dart';

class IconLabelButtonViewModel {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  IconLabelButtonViewModel({
    required this.icon,
    required this.label,
    this.isActive = false,
    this.onTap,
  });
}
