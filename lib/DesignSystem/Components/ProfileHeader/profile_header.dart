import 'package:flutter/material.dart';
import '../../shared/colors.dart';
import '../../shared/styles.dart';
import '../../shared/spacing.dart';
import '../Avatar/avatar.dart';
import '../Avatar/avatar_view_model.dart';
import 'profile_header_view_model.dart';

class ProfileHeader extends StatelessWidget {
  final ProfileHeaderViewModel viewModel;

  const ProfileHeader._({required this.viewModel});

  factory ProfileHeader.instantiate({required ProfileHeaderViewModel viewModel}) {
    return ProfileHeader._(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(height: 60, color: blue_600),
              Positioned(
                left: small,
                bottom: -40,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: white, width: 4),
                  ),
                  child: Avatar.instantiate(
                    viewModel: AvatarViewModel(
                      initials: viewModel.avatar,
                      size: 100,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: small,
                bottom: -20,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: viewModel.onSharePressed,
                      icon: const Icon(Icons.share, color: blue_500),
                    ),
                    IconButton(
                      onPressed: viewModel.onEditToggle,
                      icon: Icon(
                        viewModel.isEditing ? Icons.close : Icons.edit,
                        color: blue_500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 50),
          Padding(
            padding: EdgeInsets.all(small),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  viewModel.name,
                  style: title4.copyWith(color: primaryInk),
                ),
                SizedBox(height: tripleXS),
                Text(
                  viewModel.headline,
                  style: label2Regular.copyWith(color: secondaryInk),
                ),
                SizedBox(height: doubleXS),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: gray_600),
                    SizedBox(width: tripleXS),
                    Text(
                      viewModel.location,
                      style: label2Regular.copyWith(color: gray_600),
                    ),
                  ],
                ),
                SizedBox(height: doubleXS),
                Text(
                  '${viewModel.connections}+ conexões',
                  style: labelTextStyle.copyWith(color: blue_500),
                ),
                SizedBox(height: small),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: viewModel.onConnectPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: blue_500,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          padding: EdgeInsets.symmetric(vertical: extraSmall),
                        ),
                        child: Text(
                          'Aberto a',
                          style: label2Regular.copyWith(color: white),
                        ),
                      ),
                    ),
                    SizedBox(width: doubleXS),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: viewModel.onAddSectionPressed,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: blue_500),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          padding: EdgeInsets.symmetric(vertical: extraSmall),
                        ),
                        child: Text(
                          'Adicionar seção',
                          style: label2Regular.copyWith(color: blue_500),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
