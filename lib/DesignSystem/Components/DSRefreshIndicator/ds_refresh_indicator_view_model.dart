import 'package:flutter/material.dart';

class DSRefreshIndicatorViewModel {
  final Future<void> Function() onRefresh;
  final Widget child;
  final double displacement;
  final double strokeWidth;

  DSRefreshIndicatorViewModel({
    required this.onRefresh,
    required this.child,
    this.displacement = 40.0,
    this.strokeWidth = 2.5,
  });
}
