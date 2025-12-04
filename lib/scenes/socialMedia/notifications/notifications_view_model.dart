import 'package:flutter/material.dart';
import '../../../resources/shared/app_coordinator.dart';

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

  List<NotificationModel> _notifications = [];
  bool _isLoading = false;

  NotificationsViewModel({required this.coordinator}) {
    _loadNotifications();
  }

  List<NotificationModel> get notifications => _notifications;
  bool get isLoading => _isLoading;
  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  void _loadNotifications() {
    _isLoading = true;
    notifyListeners();

    _notifications = [
      NotificationModel(
        id: '1',
        type: 'like',
        title: 'Maria Silva curtiu sua publicação',
        description: '"Acabei de concluir minha certificação..."',
        avatar: 'MS',
        timeAgo: '5 min',
        isRead: false,
      ),
      NotificationModel(
        id: '2',
        type: 'connection',
        title: 'João Santos aceitou seu convite',
        description: 'Vocês agora estão conectados',
        avatar: 'JS',
        timeAgo: '1h',
        isRead: false,
      ),
      NotificationModel(
        id: '3',
        type: 'comment',
        title: 'Ana Costa comentou na sua publicação',
        description: '"Parabéns pela conquista! Continue assim!"',
        avatar: 'AC',
        timeAgo: '2h',
        isRead: false,
      ),
      NotificationModel(
        id: '4',
        type: 'job',
        title: 'Nova vaga para você',
        description: 'Desenvolvedor Flutter Senior - Tech Corp',
        avatar: '💼',
        timeAgo: '3h',
        isRead: true,
      ),
      NotificationModel(
        id: '5',
        type: 'mention',
        title: 'Pedro Oliveira mencionou você',
        description: '"...concordo com @VictorHugo sobre isso"',
        avatar: 'PO',
        timeAgo: '5h',
        isRead: true,
      ),
      NotificationModel(
        id: '6',
        type: 'like',
        title: 'Roberto Alves e mais 23 pessoas curtiram',
        description: 'Sua publicação sobre Flutter',
        avatar: 'RA',
        timeAgo: '1d',
        isRead: true,
      ),
      NotificationModel(
        id: '7',
        type: 'connection',
        title: 'Juliana Ferreira quer se conectar',
        description: 'Product Designer na Nubank',
        avatar: 'JF',
        timeAgo: '2d',
        isRead: true,
      ),
    ];

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
