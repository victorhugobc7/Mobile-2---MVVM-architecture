import 'package:flutter/material.dart';

class SearchBarViewModel {
  final TextEditingController controller;
  final String? hint;
  final VoidCallback? onClear;

  SearchBarViewModel({
    required this.controller,
    this.hint,
    this.onClear,
  });
}