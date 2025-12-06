import 'package:flutter/material.dart';

class ProfileHeaderViewModel extends ChangeNotifier {
  final String name;
  final String headline;
  final String location;
  final String avatar;
  final int connections;
  final bool isEditing;
  final VoidCallback? onSharePressed;
  final VoidCallback? onEditToggle;
  final VoidCallback? onConnectPressed;
  final VoidCallback? onAddSectionPressed;

  ProfileHeaderViewModel({
    required this.name,
    required this.headline,
    required this.location,
    required this.avatar,
    required this.connections,
    this.isEditing = false,
    this.onSharePressed,
    this.onEditToggle,
    this.onConnectPressed,
    this.onAddSectionPressed,
  });
}
