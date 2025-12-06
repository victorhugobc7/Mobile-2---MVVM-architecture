import 'package:flutter/material.dart';

class PostCardViewModel {
  final String id;
  final String authorName;
  final String authorTitle;
  final String authorAvatar;
  final String content;
  final String? imageUrl;
  final int likes;
  final int comments;
  final int shares;
  final String timeAgo;
  final bool isLiked;
  final VoidCallback? onLikeTapped;
  final VoidCallback? onCommentTapped;
  final VoidCallback? onShareTapped;
  final VoidCallback? onSendTapped;
  final VoidCallback? onMoreOptionsTapped;

  PostCardViewModel({
    required this.id,
    required this.authorName,
    required this.authorTitle,
    required this.authorAvatar,
    required this.content,
    this.imageUrl,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.timeAgo,
    this.isLiked = false,
    this.onLikeTapped,
    this.onCommentTapped,
    this.onShareTapped,
    this.onSendTapped,
    this.onMoreOptionsTapped,
  });
}
