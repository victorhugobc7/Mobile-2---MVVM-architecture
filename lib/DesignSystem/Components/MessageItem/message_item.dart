import 'package:flutter/material.dart';
import '../../shared/colors.dart';
import '../../shared/styles.dart';
import '../../shared/spacing.dart';
import '../Avatar/avatar.dart';
import '../Avatar/avatar_view_model.dart';
import 'message_item_view_model.dart';

class MessageItem extends StatelessWidget {
  final MessageItemViewModel viewModel;

  const MessageItem._({required this.viewModel});

  static Widget instantiate({required MessageItemViewModel viewModel}) {
    return MessageItem._(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: viewModel.onTap,
      onLongPress: viewModel.onLongPress,
      child: Container(
        color: viewModel.isUnread ? blue_100 : white,
        padding: EdgeInsets.symmetric(horizontal: small, vertical: extraSmall),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAvatar(),
            SizedBox(width: extraSmall),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  SizedBox(height: tripleXS),
                  _buildLastMessage(),
                ],
              ),
            ),
            _buildTrailing(),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Stack(
      children: [
        Avatar.instantiate(
          viewModel: AvatarViewModel(
            initials: viewModel.avatarInitials,
            size: 48,
          ),
        ),
        if (viewModel.isOnline)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: green_confirmation,
                shape: BoxShape.circle,
                border: Border.all(color: white, width: 2),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Text(
            viewModel.senderName,
            style: labelTextStyle.copyWith(
              color: primaryInk,
              fontWeight: viewModel.isUnread ? FontWeight.w600 : FontWeight.normal,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          viewModel.timeAgo,
          style: label2Regular.copyWith(
            color: viewModel.isUnread ? blue_500 : gray_500,
          ),
        ),
      ],
    );
  }

  Widget _buildLastMessage() {
    return Text(
      viewModel.lastMessage,
      style: label2Regular.copyWith(
        color: viewModel.isUnread ? primaryInk : gray_600,
        fontWeight: viewModel.isUnread ? FontWeight.w500 : FontWeight.normal,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTrailing() {
    if (viewModel.unreadCount > 0) {
      return Container(
        margin: EdgeInsets.only(left: doubleXS),
        padding: EdgeInsets.symmetric(horizontal: doubleXS, vertical: 2),
        decoration: BoxDecoration(
          color: blue_500,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          viewModel.unreadCount > 99 ? '99+' : '${viewModel.unreadCount}',
          style: label2Regular.copyWith(color: white, fontSize: 10),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
