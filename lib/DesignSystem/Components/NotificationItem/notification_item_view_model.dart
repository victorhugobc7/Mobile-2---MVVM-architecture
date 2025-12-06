import 'package:flutter/material.dart';

enum NotificationType {
  like,
  comment,
  connection,
  mention,
  jobAlert,
  general,
}

class NotificationItemViewModel {
  final String id;
  final String title;
  final String subtitle;
  final String timeAgo;
  final NotificationType type;
  final String avatarInitials;
  final bool isRead;
  final VoidCallback? onTap;
  final VoidCallback? onDismiss;

  NotificationItemViewModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    this.type = NotificationType.general,
    required this.avatarInitials,
    this.isRead = false,
    this.onTap,
    this.onDismiss,
  });
}
