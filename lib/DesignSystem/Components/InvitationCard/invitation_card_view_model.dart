import 'package:flutter/material.dart';

class InvitationCardViewModel {
  final String id;
  final String name;
  final String title;
  final String? avatarUrl;
  final String avatarInitials;
  final String timeAgo;
  final VoidCallback? onAcceptTapped;
  final VoidCallback? onDeclineTapped;
  final VoidCallback? onTap;

  InvitationCardViewModel({
    required this.id,
    required this.name,
    required this.title,
    this.avatarUrl,
    required this.avatarInitials,
    required this.timeAgo,
    this.onAcceptTapped,
    this.onDeclineTapped,
    this.onTap,
  });
}
