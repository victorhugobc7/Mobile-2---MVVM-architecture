import 'package:flutter/material.dart';

class FeedAppBarViewModel {
  final String? logoAssetPath;
  final String searchPlaceholder;
  final VoidCallback? onSearchTapped;
  final VoidCallback? onMessagesTapped;
  final int? unreadMessagesCount;
  final List<Widget>? additionalActions;

  FeedAppBarViewModel({
    this.logoAssetPath,
    this.searchPlaceholder = 'Pesquisar',
    this.onSearchTapped,
    this.onMessagesTapped,
    this.unreadMessagesCount,
    this.additionalActions,
  });
}
