import 'package:flutter/material.dart';

class StatCardViewModel {
  final IconData icon;
  final String value;
  final String label;
  final VoidCallback? onTap;

  StatCardViewModel({
    required this.icon,
    required this.value,
    required this.label,
    this.onTap,
  });
}
