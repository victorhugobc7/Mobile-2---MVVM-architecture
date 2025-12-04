import 'package:flutter/material.dart';

class SwitchButtonViewModel {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String? title;

  SwitchButtonViewModel({
    required this.value,
    required this.onChanged,
    this.title,
  });
}
