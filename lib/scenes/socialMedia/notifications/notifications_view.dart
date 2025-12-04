import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../resources/shared/colors.dart';
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
              title: const Text(
                'Notificações',
                style: TextStyle(
                  color: primaryInk,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              actions: [
                if (vm.unreadCount > 0)
                  TextButton(
                    onPressed: vm.markAllAsRead,
                    child: const Text(
                      'Marcar todas',
                      style: TextStyle(color: blue_500),
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
          Icon(
            Icons.notifications_none,
            size: 80,
            color: gray_400,
          ),
          const SizedBox(height: 16),
          const Text(
            'Nenhuma notificação',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: gray_600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Você está em dia!',
            style: TextStyle(
              fontSize: 14,
              color: gray_500,
            ),
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
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.delete, color: white),
      ),
      child: InkWell(
        onTap: () => vm.markAsRead(notification.id),
        child: Container(
          color: notification.isRead ? white : blue_100,
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNotificationIcon(notification),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
                        color: primaryInk,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification.description,
                      style: const TextStyle(
                        fontSize: 13,
                        color: gray_600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification.timeAgo,
                      style: const TextStyle(
                        fontSize: 12,
                        color: gray_500,
                      ),
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
      return CircleAvatar(
        radius: 24,
        backgroundColor: navy_700,
        child: Text(
          notification.avatar,
          style: const TextStyle(
            color: white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      );
    }

    return CircleAvatar(
      radius: 24,
      backgroundColor: gray_200,
      child: Icon(iconData, color: iconColor, size: 24),
    );
  }
}
