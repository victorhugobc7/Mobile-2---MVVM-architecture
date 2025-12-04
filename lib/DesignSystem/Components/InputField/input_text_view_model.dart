import 'package:flutter/material.dart';

class InputTextViewModel {
  final bool hasTitle;
  final TextEditingController controller;
  final String placeholder;
  final String? title;
  bool password;
  final Widget? suffixIcon;
  final bool isEnabled;
  final String? Function(String?)? validator;
  final VoidCallback? togglePasswordVisibility;

  InputTextViewModel({
    required this.controller,
    required this.placeholder,
    required this.password,
    this.suffixIcon,
    this.isEnabled = true,
    this.hasTitle = false,
    this.title,
    this.validator,
    this.togglePasswordVisibility,
  });
}
