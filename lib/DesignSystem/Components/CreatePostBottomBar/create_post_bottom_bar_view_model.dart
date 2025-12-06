import 'package:flutter/material.dart';

class CreatePostBottomBarViewModel extends ChangeNotifier {
  final VoidCallback? onCameraPressed;
  final VoidCallback? onImagePressed;
  final VoidCallback? onVideoPressed;
  final VoidCallback? onDocumentPressed;

  CreatePostBottomBarViewModel({
    this.onCameraPressed,
    this.onImagePressed,
    this.onVideoPressed,
    this.onDocumentPressed,
  });
}
