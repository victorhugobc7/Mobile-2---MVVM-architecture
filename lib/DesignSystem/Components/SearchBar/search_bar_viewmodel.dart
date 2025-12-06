import 'package:flutter/material.dart';

class SearchBarViewModel {
  final TextEditingController? controller;
  final String placeholder;
  final bool isReadOnly;
  final VoidCallback? onTap;
  final VoidCallback? onClear;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  SearchBarViewModel({
    this.controller,
    this.placeholder = 'Pesquisar',
    this.isReadOnly = false,
    this.onTap,
    this.onClear,
    this.onChanged,
    this.onSubmitted,
  });
}