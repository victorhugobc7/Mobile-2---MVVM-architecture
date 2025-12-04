import 'package:flutter/material.dart';
import '../../../../resources/shared/colors.dart';
import '../../../../resources/shared/styles.dart';


class ActionCardViewModel {
  final String title;
  final String content;
  final IconData? icon;
  final String? hoverText;

  ActionCardViewModel({
    required this.title,
    required this.content,
    this.hoverText,
    this.icon});
}