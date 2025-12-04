import 'package:flutter/material.dart';
import '../../Pill/pill_viewmodel.dart';

class ContentCardViewModel {
  final String title;
  final int viewCount;
  final double? width;
  final double? height;
  final PillViewModel? pillViewModel;
  final bool isBookmarked;
  final VoidCallback? onTap;
  final VoidCallback? onBookmarkTap;

  ContentCardViewModel({
    required this.title,
    required this.viewCount,
    this.width,
    this.height,
    this.pillViewModel,
    this.isBookmarked = false,
    this.onTap,
    this.onBookmarkTap,
  });
}
