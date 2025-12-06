import 'package:flutter/material.dart';
import '../../shared/colors.dart';
import '../../shared/styles.dart';
import '../../shared/spacing.dart';
import '../Avatar/avatar.dart';
import '../Avatar/avatar_view_model.dart';
import 'notification_item_view_model.dart';

class NotificationItem extends StatelessWidget {
  final NotificationItemViewModel viewModel;

  const NotificationItem._({required this.viewModel});

  static Widget instantiate({required NotificationItemViewModel viewModel}) {
    return NotificationItem._(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(viewModel.id),
      direction: viewModel.onDismiss != null
          ? DismissDirection.endToStart
          : DismissDirection.none,
      onDismissed: (_) => viewModel.onDismiss?.call(),
      background: Container(
        color: red_error,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: small),
        child: const Icon(Icons.delete, color: white),
      ),
      child: Container(
        color: viewModel.isRead ? white : blue_100,
        child: InkWell(
          onTap: viewModel.onTap,
          child: Padding(
            padding: EdgeInsets.all(small),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAvatar(),
                SizedBox(width: extraSmall),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitle(),
                      SizedBox(height: tripleXS),
                      _buildSubtitle(),
                      SizedBox(height: tripleXS),
                      _buildTimeAgo(),
                    ],
                  ),
                ),
                _buildTypeIcon(),
              ],
            ),
          ),
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
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getTypeIcon(),
              size: 12,
              color: _getTypeColor(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      viewModel.title,
      style: labelTextStyle.copyWith(
        color: primaryInk,
        fontWeight: viewModel.isRead ? FontWeight.normal : FontWeight.w600,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSubtitle() {
    return Text(
      viewModel.subtitle,
      style: label2Regular.copyWith(color: gray_600),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTimeAgo() {
    return Text(
      viewModel.timeAgo,
      style: label2Regular.copyWith(color: gray_500),
    );
  }

  Widget _buildTypeIcon() {
    if (!viewModel.isRead) {
      return Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: blue_500,
          shape: BoxShape.circle,
        ),
      );
    }
    return const SizedBox.shrink();
  }

  IconData _getTypeIcon() {
    switch (viewModel.type) {
      case NotificationType.like:
        return Icons.thumb_up;
      case NotificationType.comment:
        return Icons.comment;
      case NotificationType.connection:
        return Icons.person_add;
      case NotificationType.mention:
        return Icons.alternate_email;
      case NotificationType.jobAlert:
        return Icons.work;
      case NotificationType.general:
        return Icons.notifications;
    }
  }

  Color _getTypeColor() {
    switch (viewModel.type) {
      case NotificationType.like:
        return blue_500;
      case NotificationType.comment:
        return green_confirmation;
      case NotificationType.connection:
        return navy_700;
      case NotificationType.mention:
        return yellow_marigold;
      case NotificationType.jobAlert:
        return blue_600;
      case NotificationType.general:
        return gray_600;
    }
  }
}
