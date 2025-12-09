import 'notifications_view_model.dart';

class NotificationsService {
  Future<List<NotificationModel>> fetchNotifications() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
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
        title: 'Silvano comentou na sua publicação',
        description: '"Parabéns! Continue assim 👍',
        avatar: 'AC',
        timeAgo: '2h',
        isRead: false,
      ),
      NotificationModel(
        id: '4',
        type: 'job',
        title: 'Nova vaga para você',
        description: 'Desenvolvedor Flutter junior - Tech Corp',
        avatar: '💼',
        timeAgo: '3h',
        isRead: true,
      ),
      NotificationModel(
        id: '5',
        type: 'mention',
        title: 'Thiago Oliveira mencionou você',
        description: '"@VictorHugo o que você acha dessa abordagem?"',
        avatar: 'PO',
        timeAgo: '5h',
        isRead: true,
      ),
    ];
  }

  Future<void> markAsRead(String notificationId) async {
    await Future.delayed(const Duration(milliseconds: 100));
  }

  Future<void> markAllAsRead() async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  Future<bool> deleteNotification(String notificationId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Future<int> getUnreadCount() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return 3;
  }

  Future<void> subscribeToPush(String token) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
