import 'package:flutter/material.dart';

class ExperienceItemViewModel {
  final String title;
  final String company;
  final String duration;
  final String location;
  final String? description;
  final String? logoUrl;
  final VoidCallback? onTap;

  ExperienceItemViewModel({
    required this.title,
    required this.company,
    required this.duration,
    required this.location,
    this.description,
    this.logoUrl,
    this.onTap,
  });
}
