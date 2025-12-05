import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../DesignSystem/shared/colors.dart';
import '../../../DesignSystem/shared/styles.dart';
import '../../../DesignSystem/shared/spacing.dart';
import '../../../DesignSystem/Components/Avatar/avatar.dart';
import '../../../DesignSystem/Components/Avatar/avatar_view_model.dart';
import 'notifications_view_model.dart';

class NotificationsView extends StatelessWidget {
  final NotificationsViewModel viewModel;

  const NotificationsView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<NotificationsViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: white,
            appBar: AppBar(
              backgroundColor: white,
              elevation: 1,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: primaryInk),
                onPressed: vm.goBack,
              ),
              title: Text(
                'Notificações',
                style: labelTextStyle.copyWith(color: primaryInk, fontSize: 18),
              ),
              actions: [
                if (vm.unreadCount > 0)
                  TextButton(
                    onPressed: vm.markAllAsRead,
                    child: Text(
                      'Marcar todas',
                      style: label2Regular.copyWith(color: blue_500),
                    ),
                  ),
              ],
            ),
            body: vm.isLoading
                ? const Center(child: CircularProgressIndicator())
                : vm.notifications.isEmpty
                    ? _buildEmptyState()
                    : ListView.separated(
                        itemCount: vm.notifications.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          return _buildNotificationItem(
                            vm.notifications[index],
                            vm,
                          );
                        },
                      ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.notifications_none, size: 80, color: gray_400),
          SizedBox(height: small),
          Text(
            'Nenhuma notificação',
            style: labelTextStyle.copyWith(color: gray_600, fontSize: 18),
          ),
          SizedBox(height: doubleXS),
          Text(
            'Você está em dia!',
            style: label2Regular.copyWith(color: gray_500),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(NotificationModel notification, NotificationsViewModel vm) {
    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => vm.deleteNotification(notification.id),
      background: Container(
        color: red_error,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: small),
        child: const Icon(Icons.delete, color: white),
      ),
      child: InkWell(
        onTap: () => vm.markAsRead(notification.id),
        child: Container(
          color: notification.isRead ? white : blue_100,
          padding: EdgeInsets.all(small),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNotificationIcon(notification),
              SizedBox(width: extraSmall),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title,
                      style: labelTextStyle.copyWith(
                        fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
                        color: primaryInk,
                      ),
                    ),
                    SizedBox(height: tripleXS),
                    Text(
                      notification.description,
                      style: label2Regular.copyWith(color: gray_600, fontSize: 13),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: tripleXS),
                    Text(
                      notification.timeAgo,
                      style: label2Regular.copyWith(color: gray_500),
                    ),
                  ],
                ),
              ),
              if (!notification.isRead)
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: blue_500,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationIcon(NotificationModel notification) {
    IconData iconData;
    Color iconColor;

    switch (notification.type) {
      case 'like':
        iconData = Icons.thumb_up;
        iconColor = blue_500;
        break;
      case 'comment':
        iconData = Icons.comment;
        iconColor = green_confirmation;
        break;
      case 'connection':
        iconData = Icons.people;
        iconColor = navy_700;
        break;
      case 'job':
        iconData = Icons.work;
        iconColor = yellow_marigold;
        break;
      case 'mention':
        iconData = Icons.alternate_email;
        iconColor = mint_dark;
        break;
      default:
        iconData = Icons.notifications;
        iconColor = gray_600;
    }

    if (notification.avatar.length <= 2 && !notification.avatar.contains(RegExp(r'[^\w]'))) {
      return Avatar.instantiate(
        viewModel: AvatarViewModel(
          initials: notification.avatar,
          size: 48,
        ),
      );
    }

    return Container(
      width: 48,
      height: 48,
      decoration: const BoxDecoration(
        color: gray_200,
        shape: BoxShape.circle,
      ),
      child: Icon(iconData, color: iconColor, size: 24),
    );
  }
}
