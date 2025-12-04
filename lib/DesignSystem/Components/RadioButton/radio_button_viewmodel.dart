import 'package:flutter/material.dart';

class RadioButtonViewModel<T> {
  final T value;
  final T groupValue;
  final String? title;
  final ValueChanged<T?> onChanged;
  final bool isDisabled;

  RadioButtonViewModel({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.title,
    this.isDisabled = false,
  });

  bool get isSelected => value == groupValue;
}
