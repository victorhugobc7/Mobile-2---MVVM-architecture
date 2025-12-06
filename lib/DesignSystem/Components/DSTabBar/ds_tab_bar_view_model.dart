import 'package:flutter/material.dart';

class DSTabBarViewModel extends ChangeNotifier {
  final List<String> tabs;
  int _selectedIndex;
  final ValueChanged<int>? onTabChanged;

  DSTabBarViewModel({
    required this.tabs,
    int selectedIndex = 0,
    this.onTabChanged,
  }) : _selectedIndex = selectedIndex;

  int get selectedIndex => _selectedIndex;

  void selectTab(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      onTabChanged?.call(index);
      notifyListeners();
    }
  }
}
