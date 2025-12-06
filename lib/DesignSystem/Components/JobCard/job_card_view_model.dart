import 'package:flutter/material.dart';

class JobCardViewModel {
  final String id;
  final String title;
  final String company;
  final String location;
  final String salary;
  final String postedTime;
  final List<String> tags;
  final bool isSaved;
  final VoidCallback? onTap;
  final VoidCallback? onSaveTapped;

  JobCardViewModel({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.postedTime,
    this.tags = const [],
    this.isSaved = false,
    this.onTap,
    this.onSaveTapped,
  });
}
