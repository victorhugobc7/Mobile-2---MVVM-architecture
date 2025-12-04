import 'messages_view_model.dart';

class MessagesService {
  Future<List<MessageModel>> fetchConversations() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      MessageModel(
        id: '1',
        contactName: 'Maria Silva',
        contactAvatar: 'MS',
        lastMessage: 'Oi! Podemos conversar sobre a vaga?',
        timeAgo: '2 min',
        isOnline: true,
        unreadCount: 2,
      ),
      MessageModel(
        id: '2',
        contactName: 'João Santos',
        contactAvatar: 'JS',
        lastMessage: 'Obrigado pelo feedback! 🙏',
        timeAgo: '1 h',
        isOnline: true,
      ),
      MessageModel(
        id: '3',
        contactName: 'Ana Costa',
        contactAvatar: 'AC',
        lastMessage: 'Vou dar uma olhada e te retorno',
        timeAgo: '3 h',
        isOnline: false,
        unreadCount: 1,
      ),
      MessageModel(
        id: '4',
        contactName: 'Pedro Oliveira',
        contactAvatar: 'PO',
        lastMessage: 'Combinado! Até amanhã então.',
        timeAgo: '1 d',
        isOnline: false,
      ),
      MessageModel(
        id: '5',
        contactName: 'Carla Mendes',
        contactAvatar: 'CM',
        lastMessage: 'Foi ótimo conhecer você no evento!',
        timeAgo: '3 d',
        isOnline: false,
      ),
    ];
  }

  Future<bool> sendMessage(String conversationId, String message) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }

  Future<void> markAsRead(String conversationId) async {
    await Future.delayed(const Duration(milliseconds: 100));
  }

  Future<bool> deleteConversation(String conversationId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Future<List<MessageModel>> searchConversations(String query) async {
    final conversations = await fetchConversations();
    return conversations.where((m) =>
      m.contactName.toLowerCase().contains(query.toLowerCase()) ||
      m.lastMessage.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  Future<String> startConversation(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return 'new_conversation_id';
  }
}
