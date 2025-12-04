import 'package:flutter/material.dart';

class AccordionViewModel {
  final String title;
  final Widget content;
  bool isExpanded;

  AccordionViewModel({
    required this.title,
    required this.content,
    this.isExpanded = false,
  });
}
