import 'package:flutter/material.dart';
import 'content_card_view_model.dart';
import '../../Pill/pill.dart';
import '../../../../resources/shared/colors.dart';

class ContentCard extends StatefulWidget {
  final ContentCardViewModel viewModel;

  const ContentCard._({super.key, required this.viewModel});

  static Widget instantiate({required ContentCardViewModel viewModel}) {
    return ContentCard._(viewModel: viewModel);
  }

  @override
  State<ContentCard> createState() => _ContentCardState();
}

class _ContentCardState extends State<ContentCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final vm = widget.viewModel;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
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
            border: Border.all(color: gray_300),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Expanded(
                child: Text(
                  vm.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: primaryInk,
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Bottom row: Pill (optional) + Views + Bookmark
              Row(
                children: [
                  // Optional Pill
                  if (vm.pillViewModel != null)
                    Pill(viewModel: vm.pillViewModel!),
                  
                  const Spacer(),
                  
                  // View count
                  Text(
                    '${vm.viewCount}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: gray_600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Views',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: gray_600,
                    ),
                  ),
                  
                  const SizedBox(width: 8),
                  
                  // Bookmark icon
                  GestureDetector(
                    onTap: vm.onBookmarkTap,
                    child: Icon(
                      vm.isBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_outline,
                      color: vm.isBookmarked ? blue_500 : gray_500,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
