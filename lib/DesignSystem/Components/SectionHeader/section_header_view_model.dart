import 'package:flutter/material.dart';

class SectionHeaderViewModel {
  final String title;
  final String? actionText;
  final VoidCallback? onActionTapped;

  SectionHeaderViewModel({
    required this.title,
    this.actionText,
    this.onActionTapped,
  });
}
