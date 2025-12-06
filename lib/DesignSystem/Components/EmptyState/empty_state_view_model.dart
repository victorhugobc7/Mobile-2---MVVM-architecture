import 'package:flutter/material.dart';

class EmptyStateViewModel {
  final IconData icon;
  final String title;
  final String subtitle;
  final double iconSize;

  EmptyStateViewModel({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.iconSize = 80,
  });
}
