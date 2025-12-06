import 'package:flutter/material.dart';

class EducationItemViewModel {
  final String institution;
  final String degree;
  final String period;
  final String? logoUrl;
  final VoidCallback? onTap;

  EducationItemViewModel({
    required this.institution,
    required this.degree,
    required this.period,
    this.logoUrl,
    this.onTap,
  });
}
