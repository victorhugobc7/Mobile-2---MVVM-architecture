import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../DesignSystem/shared/colors.dart';
import '../../../DesignSystem/Components/EmptyState/empty_state.dart';
import '../../../DesignSystem/Components/SimpleAppBar/simple_app_bar.dart';
import '../../../DesignSystem/Components/NotificationItem/notification_item.dart';
import '../../../DesignSystem/Components/NotificationItem/notification_item_view_model.dart';
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
            appBar: SimpleAppBar.instantiate(viewModel: vm.appBarViewModel),
            body: vm.isLoading
                ? const Center(child: CircularProgressIndicator())
                : vm.notifications.isEmpty
                    ? EmptyState.instantiate(viewModel: vm.emptyStateViewModel)
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

  Widget _buildNotificationItem(NotificationModel notification, NotificationsViewModel vm) {
    return NotificationItem.instantiate(
      viewModel: NotificationItemViewModel(
        id: notification.id,
        title: notification.title,
        subtitle: notification.description,
        timeAgo: notification.timeAgo,
        type: _mapNotificationType(notification.type),
        avatarInitials: notification.avatar,
        isRead: notification.isRead,
        onTap: () => vm.markAsRead(notification.id),
        onDismiss: () => vm.deleteNotification(notification.id),
      ),
    );
  }

  NotificationType _mapNotificationType(String type) {
    switch (type) {
      case 'like':
        return NotificationType.like;
      case 'comment':
        return NotificationType.comment;
      case 'connection':
        return NotificationType.connection;
      case 'job':
        return NotificationType.jobAlert;
      case 'mention':
        return NotificationType.mention;
      default:
        return NotificationType.general;
    }
  }
}
