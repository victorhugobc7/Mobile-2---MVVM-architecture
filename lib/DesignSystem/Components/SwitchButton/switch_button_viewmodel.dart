import 'package:flutter/material.dart';

class SwitchButtonViewModel {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String? title;
  final bool showLabels; // Shows "No" and "Yes" labels outside the switch
  final bool showInlineLabel; // Shows "Yes" or "No" inside the track
  final String onLabel;
  final String offLabel;

  SwitchButtonViewModel({
    required this.value,
    required this.onChanged,
    this.title,
    this.showLabels = false,
    this.showInlineLabel = true,
    this.onLabel = 'Yes',
    this.offLabel = 'No',
  });
}
