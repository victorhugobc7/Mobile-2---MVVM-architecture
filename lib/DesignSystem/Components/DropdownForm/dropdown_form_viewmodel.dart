import 'package:flutter/material.dart';

class DropdownFormViewModel<T> {
  final List<T> items;
  final T? selectedItem;
  final ValueChanged<T?> onChanged;
  final String? hint;

  DropdownFormViewModel({
    required this.items,
    required this.onChanged,
    this.selectedItem,
    this.hint,
  });
}
