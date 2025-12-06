import 'package:flutter/material.dart';

class MessageItemViewModel {
  final String id;
  final String senderName;
  final String avatarInitials;
  final String lastMessage;
  final String timeAgo;
  final bool isUnread;
  final int unreadCount;
  final bool isOnline;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  MessageItemViewModel({
    required this.id,
    required this.senderName,
    required this.avatarInitials,
    required this.lastMessage,
    required this.timeAgo,
    this.isUnread = false,
    this.unreadCount = 0,
    this.isOnline = false,
    this.onTap,
    this.onLongPress,
  });
}
