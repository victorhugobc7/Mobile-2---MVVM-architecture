import 'package:flutter/material.dart';

class CreatePostAppBarViewModel extends ChangeNotifier {
  final VoidCallback? onBackPressed;
  final VoidCallback? onPostPressed;
  final bool isPostEnabled;
  final bool isPosting;

  CreatePostAppBarViewModel({
    this.onBackPressed,
    this.onPostPressed,
    this.isPostEnabled = false,
    this.isPosting = false,
  });
}
