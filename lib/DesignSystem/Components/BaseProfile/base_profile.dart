import 'package:flutter/material.dart';
import 'base_profile_view_model.dart';
import '../../shared/colors.dart';
import '../../shared/styles.dart';
import '../../shared/spacing.dart';

class BaseProfile extends StatelessWidget {
  final BaseProfileViewModel viewModel;

  const BaseProfile._({required this.viewModel});

  static Widget instantiate({required BaseProfileViewModel viewModel}) {
    return BaseProfile._(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: viewModel.onTap,
      child: Container(
        padding: EdgeInsets.all(small),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: gray_300),
        ),
        child: Row(
          children: [
            _buildAvatar(),
            SizedBox(width: extraSmall),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    viewModel.name,
                    style: labelTextStyle.copyWith(color: primaryInk),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    viewModel.company,
                    style: paragraph2Medium.copyWith(color: primaryInk),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    viewModel.title,
                    style: label2Regular.copyWith(color: gray_600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Stack(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: gray_200,
            border: Border.all(color: gray_300, width: 1),
          ),
          child: viewModel.avatarUrl != null
              ? ClipOval(
                  child: Image.network(
                    viewModel.avatarUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => _buildInitials(),
                  ),
                )
              : _buildInitials(),
        ),
        if (viewModel.badgeIcon != null)
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: white,
                shape: BoxShape.circle,
                border: Border.all(color: gray_300, width: 1),
              ),
              child: Icon(
                viewModel.badgeIcon,
                size: 12,
                color: blue_500,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildInitials() {
    final initials = viewModel.avatarInitials ?? 
        viewModel.name.split(' ').map((e) => e.isNotEmpty ? e[0] : '').take(2).join().toUpperCase();
    
    return Center(
      child: Text(
        initials,
        style: labelTextStyle.copyWith(color: gray_600),
      ),
    );
  }
}
