import 'package:flutter/material.dart';

/// Footer action types
enum FooterActionType {
  textButtons,     // Action 1, Action 2, Action 3
  readMore,        // Read More >
  documents,       // Doc 1, Doc 2, Doc 3
  primaryAction,   // Cancel + PRIMARY ACTION button
  documentAndReadMore, // Doc 1 + Read More >
}

/// Document link model
class DocumentLink {
  final String label;
  final VoidCallback? onTap;

  DocumentLink({required this.label, this.onTap});
}

/// Action button model
class ActionButtonModel {
  final String label;
  final VoidCallback? onTap;

  ActionButtonModel({required this.label, this.onTap});
}

class ActionCardViewModel {
  // Dimensions
  final double? width;
  final double? height;

  // Card title (small text above header, e.g., "Card Title")
  final String? cardTitle;

  // Header section
  final IconData? headerIcon;
  final String? headerTitle;

  // Content
  final String? description;

  // Footer configuration
  final FooterActionType? footerType;
  final List<ActionButtonModel>? actionButtons;
  final List<DocumentLink>? documents;
  final String? readMoreLabel;
  final VoidCallback? onReadMoreTap;
  final String? cancelLabel;
  final VoidCallback? onCancelTap;
  final String? primaryLabel;
  final VoidCallback? onPrimaryTap;

  // General
  final VoidCallback? onTap;

  ActionCardViewModel({
    this.width,
    this.height,
    this.cardTitle,
    this.headerIcon,
    this.headerTitle,
    this.description,
    this.footerType,
    this.actionButtons,
    this.documents,
    this.readMoreLabel,
    this.onReadMoreTap,
    this.cancelLabel,
    this.onCancelTap,
    this.primaryLabel,
    this.onPrimaryTap,
    this.onTap,
  });
}