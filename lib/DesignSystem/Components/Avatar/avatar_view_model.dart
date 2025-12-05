import 'package:flutter/material.dart';

class AvatarViewModel {
  final String? imageUrl;
  final String initials;
  final double size;
  final bool showOnlineIndicator;
  final bool isOnline;
  final VoidCallback? onTap;

  AvatarViewModel({
    this.imageUrl,
    required this.initials,
    this.size = 48,
    this.showOnlineIndicator = false,
    this.isOnline = false,
    this.onTap,
  });
}
