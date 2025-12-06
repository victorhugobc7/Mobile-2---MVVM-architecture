import 'package:flutter/material.dart';

class SimpleAppBarViewModel extends ChangeNotifier {
  final String title;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool centerTitle;
  final double? elevation;

  SimpleAppBarViewModel({
    required this.title,
    this.onBackPressed,
    this.actions,
    this.backgroundColor,
    this.foregroundColor,
    this.centerTitle = false,
    this.elevation,
  });
}
