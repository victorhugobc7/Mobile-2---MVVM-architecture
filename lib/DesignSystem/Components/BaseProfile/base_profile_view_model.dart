import 'package:flutter/material.dart';

class BaseProfileViewModel {
  final String name;
  final String company;
  final String title;
  final String? avatarUrl;
  final String? avatarInitials;
  final IconData? badgeIcon;
  final VoidCallback? onTap;

  BaseProfileViewModel({
    required this.name,
    required this.company,
    required this.title,
    this.avatarUrl,
    this.avatarInitials,
    this.badgeIcon,
    this.onTap,
  });
}
