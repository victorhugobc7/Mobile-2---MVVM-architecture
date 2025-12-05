import 'package:flutter/material.dart';
import '../../../resources/shared/app_coordinator.dart';
import 'notifications_service.dart';

class NotificationModel {
  final String id;
  final String type; // 'like', 'comment', 'connection', 'job', 'mention'
  final String title;
  final String description;
  final String avatar;
  final String timeAgo;
  bool isRead;

  NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.avatar,
    required this.timeAgo,
    this.isRead = false,
  });
}

class NotificationsViewModel extends ChangeNotifier {
  final AppCoordinator coordinator;
  final NotificationsService service;

  List<NotificationModel> _notifications = [];
  bool _isLoading = false;

  NotificationsViewModel({required this.coordinator, required this.service}) {
    _loadNotifications();
  }

  List<NotificationModel> get notifications => _notifications;
  bool get isLoading => _isLoading;
  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  Future<void> _loadNotifications() async {
    _isLoading = true;
    notifyListeners();

    try {
      _notifications = await service.fetchNotifications();
    } catch (e) {
      // Handle error
    }

    _isLoading = false;
    notifyListeners();
  }

  void markAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index].isRead = true;
      notifyListeners();
    }
  }

  void markAllAsRead() {
    for (var notification in _notifications) {
      notification.isRead = true;
    }
    notifyListeners();
  }

  void deleteNotification(String id) {
    _notifications.removeWhere((n) => n.id == id);
    notifyListeners();
  }

  void goBack() {
    coordinator.pop();
  }
}
