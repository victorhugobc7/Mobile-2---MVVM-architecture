import 'package:flutter/material.dart';
import '../../shared/colors.dart';
import '../../shared/styles.dart';
import 'profile_section_header_view_model.dart';

class ProfileSectionHeader extends StatelessWidget {
  final ProfileSectionHeaderViewModel viewModel;

  const ProfileSectionHeader._({required this.viewModel});

  factory ProfileSectionHeader.instantiate({required ProfileSectionHeaderViewModel viewModel}) {
    return ProfileSectionHeader._(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          viewModel.title,
          style: labelTextStyle.copyWith(
            color: primaryInk,
            fontSize: viewModel.fontSize,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (viewModel.showAddButton)
              IconButton(
                icon: const Icon(Icons.add, size: 20, color: gray_600),
                onPressed: viewModel.onAddPressed,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            if (viewModel.showEditButton)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: IconButton(
                  icon: const Icon(Icons.edit, size: 20, color: gray_600),
                  onPressed: viewModel.onEditPressed,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
