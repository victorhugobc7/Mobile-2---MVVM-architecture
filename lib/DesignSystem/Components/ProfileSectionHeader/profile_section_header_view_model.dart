import 'package:flutter/material.dart';

class ProfileSectionHeaderViewModel extends ChangeNotifier {
  final String title;
  final bool showEditButton;
  final bool showAddButton;
  final VoidCallback? onEditPressed;
  final VoidCallback? onAddPressed;
  final double fontSize;

  ProfileSectionHeaderViewModel({
    required this.title,
    this.showEditButton = false,
    this.showAddButton = false,
    this.onEditPressed,
    this.onAddPressed,
    this.fontSize = 18,
  });
}
