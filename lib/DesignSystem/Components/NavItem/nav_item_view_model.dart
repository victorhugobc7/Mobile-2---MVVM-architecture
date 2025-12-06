import 'package:flutter/material.dart';

class NavItemViewModel {
  final IconData icon;
  final String label;
  final bool isActive;
  final int? badgeCount;
  final VoidCallback? onTap;

  NavItemViewModel({
    required this.icon,
    required this.label,
    this.isActive = false,
    this.badgeCount,
    this.onTap,
  });
}
