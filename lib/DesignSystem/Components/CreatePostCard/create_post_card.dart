import 'package:flutter/material.dart';
import '../../shared/colors.dart';
import '../../shared/styles.dart';
import '../../shared/spacing.dart';
import '../Avatar/avatar.dart';
import '../Avatar/avatar_view_model.dart';
import 'create_post_card_view_model.dart';

class CreatePostCard extends StatelessWidget {
  final CreatePostCardViewModel viewModel;

  const CreatePostCard._({required this.viewModel});

  static Widget instantiate({required CreatePostCardViewModel viewModel}) {
    return CreatePostCard._(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: tripleXS),
      padding: EdgeInsets.all(small),
      color: white,
      child: Row(
        children: [
          Avatar.instantiate(
            viewModel: AvatarViewModel(
              initials: viewModel.avatarInitials,
              size: viewModel.avatarSize,
            ),
          ),
          SizedBox(width: extraSmall),
          Expanded(
            child: GestureDetector(
              onTap: viewModel.onTap,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: small, vertical: extraSmall),
                decoration: BoxDecoration(
                  border: Border.all(color: gray_400),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  viewModel.placeholder,
                  style: paragraph2Medium.copyWith(color: gray_600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
