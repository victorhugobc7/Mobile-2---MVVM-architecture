import 'package:flutter/material.dart';

class CreatePostCardViewModel {
  final String avatarInitials;
  final String placeholder;
  final double avatarSize;
  final VoidCallback? onTap;

  CreatePostCardViewModel({
    required this.avatarInitials,
    this.placeholder = 'Começar publicação',
    this.avatarSize = 48,
    this.onTap,
  });
}
