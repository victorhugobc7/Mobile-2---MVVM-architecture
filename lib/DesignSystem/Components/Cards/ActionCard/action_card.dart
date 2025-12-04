import 'package:flutter/material.dart';
import 'action_card_view_model.dart';
import '../../../../resources/shared/colors.dart';

class ActionCard extends StatefulWidget {
  final ActionCardViewModel viewModel;

  const ActionCard._({required this.viewModel});

  static Widget instantiate({required ActionCardViewModel viewModel}) {
    return ActionCard._(viewModel: viewModel);
  }

  @override
  State<ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final vm = widget.viewModel;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: vm.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: vm.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: vm.width,
          height: vm.height,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _isHovered ? blue_500 : gray_300,
              width: _isHovered ? 1.5 : 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: blue_500.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Card title (small text, e.g., "Card Title")
              if (vm.cardTitle != null) ...[
                Text(
                  vm.cardTitle!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: gray_600,
                  ),
                ),
                const SizedBox(height: 8),
              ],

              // Header with optional icon + title
              if (vm.headerTitle != null) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (vm.headerIcon != null) ...[
                      Icon(
                        vm.headerIcon,
                        size: 20,
                        color: gray_600,
                      ),
                      const SizedBox(width: 8),
                    ],
                    Expanded(
                      child: Text(
                        vm.headerTitle!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: primaryInk,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],

              // Description
              if (vm.description != null) ...[
                Expanded(
                  child: Text(
                    vm.description!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: secondaryInk,
                      height: 1.5,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                  ),
                ),
              ],

              // Footer
              if (vm.footerType != null) ...[
                const SizedBox(height: 16),
                _buildFooter(vm),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(ActionCardViewModel vm) {
    switch (vm.footerType!) {
      case FooterActionType.textButtons:
        return _buildTextButtonsFooter(vm);
      case FooterActionType.readMore:
        return _buildReadMoreFooter(vm);
      case FooterActionType.documents:
        return _buildDocumentsFooter(vm);
      case FooterActionType.primaryAction:
        return _buildPrimaryActionFooter(vm);
      case FooterActionType.documentAndReadMore:
        return _buildDocumentAndReadMoreFooter(vm);
    }
  }

  Widget _buildTextButtonsFooter(ActionCardViewModel vm) {
    if (vm.actionButtons == null || vm.actionButtons!.isEmpty) {
      return const SizedBox.shrink();
    }
    return Row(
      children: vm.actionButtons!.map((action) {
        return Padding(
          padding: const EdgeInsets.only(right: 16),
          child: GestureDetector(
            onTap: action.onTap,
            child: Text(
              action.label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: blue_500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildReadMoreFooter(ActionCardViewModel vm) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: vm.onReadMoreTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              vm.readMoreLabel ?? 'Read More',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: blue_500,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.chevron_right,
              size: 18,
              color: blue_500,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentsFooter(ActionCardViewModel vm) {
    if (vm.documents == null || vm.documents!.isEmpty) {
      return const SizedBox.shrink();
    }
    return Row(
      children: vm.documents!.map((doc) {
        return Padding(
          padding: const EdgeInsets.only(right: 16),
          child: GestureDetector(
            onTap: doc.onTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.description_outlined,
                  size: 16,
                  color: blue_500,
                ),
                const SizedBox(width: 4),
                Text(
                  doc.label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: blue_500,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPrimaryActionFooter(ActionCardViewModel vm) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Cancel button
        GestureDetector(
          onTap: vm.onCancelTap,
          child: Text(
            vm.cancelLabel ?? 'Cancel',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: blue_500,
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Primary action button
        GestureDetector(
          onTap: vm.onPrimaryTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: blue_500,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              vm.primaryLabel ?? 'PRIMARY ACTION',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: white,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentAndReadMoreFooter(ActionCardViewModel vm) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Document link
        if (vm.documents != null && vm.documents!.isNotEmpty)
          GestureDetector(
            onTap: vm.documents!.first.onTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.description_outlined,
                  size: 16,
                  color: blue_500,
                ),
                const SizedBox(width: 4),
                Text(
                  vm.documents!.first.label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: blue_500,
                  ),
                ),
              ],
            ),
          ),
        // Read more
        GestureDetector(
          onTap: vm.onReadMoreTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                vm.readMoreLabel ?? 'Read More',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: blue_500,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.chevron_right,
                size: 18,
                color: blue_500,
              ),
            ],
          ),
        ),
      ],
    );
  }
}