import 'package:flutter/material.dart';

class TagViewModel {
  final String text;
  final Color color;
  final double backgroundOpacity;

  TagViewModel({
    required this.text,
    required this.color,
    this.backgroundOpacity = 0.15,
  });
}
