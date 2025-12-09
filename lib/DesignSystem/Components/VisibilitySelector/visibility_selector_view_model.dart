import 'package:flutter/material.dart';

enum VisibilityOption {
  anyone,
  connectionsOnly,
  groupMembers,
}

class VisibilitySelectorViewModel {
  final String label;
  final IconData icon;
  final VisibilityOption selectedOption;
  final VoidCallback? onTap;

  const VisibilitySelectorViewModel({
    required this.label,
    this.icon = Icons.public,
    this.selectedOption = VisibilityOption.anyone,
    this.onTap,
  });

  String get displayLabel {
    switch (selectedOption) {
      case VisibilityOption.anyone:
        return label.isNotEmpty ? label : 'Qualquer pessoa';
      case VisibilityOption.connectionsOnly:
        return 'Somente conexões';
      case VisibilityOption.groupMembers:
        return 'Membros do grupo';
    }
  }

  IconData get displayIcon {
    switch (selectedOption) {
      case VisibilityOption.anyone:
        return Icons.public;
      case VisibilityOption.connectionsOnly:
        return Icons.people;
      case VisibilityOption.groupMembers:
        return Icons.group;
    }
  }
}
