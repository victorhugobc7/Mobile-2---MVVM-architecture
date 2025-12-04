import 'package:flutter/material.dart';
import '../../../resources/shared/app_coordinator.dart';

class MessageModel {
  final String id;
  final String contactName;
  final String contactAvatar;
  final String lastMessage;
  final String timeAgo;
  final bool isOnline;
  final int unreadCount;

  MessageModel({
    required this.id,
    required this.contactName,
    required this.contactAvatar,
    required this.lastMessage,
    required this.timeAgo,
    this.isOnline = false,
    this.unreadCount = 0,
  });
}

class MessagesViewModel extends ChangeNotifier {
  final AppCoordinator coordinator;

  List<MessageModel> _messages = [];
  bool _isLoading = false;
  String _searchQuery = '';

  MessagesViewModel({required this.coordinator}) {
    _loadMessages();
  }

  List<MessageModel> get messages {
    if (_searchQuery.isEmpty) return _messages;
    return _messages.where((m) => 
      m.contactName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      m.lastMessage.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();
  }
  
  bool get isLoading => _isLoading;
  int get totalUnread => _messages.fold(0, (sum, m) => sum + m.unreadCount);

  void _loadMessages() {
    _isLoading = true;
    notifyListeners();

    _messages = [
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
        lastMessage: 'Excelente trabalho no projeto!',
        timeAgo: '1 dia',
        isOnline: false,
      ),
      MessageModel(
        id: '5',
        contactName: 'Fernanda Lima',
        contactAvatar: 'FL',
        lastMessage: 'Quando podemos agendar uma reunião?',
        timeAgo: '2 dias',
        isOnline: false,
      ),
      MessageModel(
        id: '6',
        contactName: 'Roberto Alves',
        contactAvatar: 'RA',
        lastMessage: 'Segue o documento que mencionei',
        timeAgo: '3 dias',
        isOnline: true,
      ),
      MessageModel(
        id: '7',
        contactName: 'Beatriz Santos',
        contactAvatar: 'BS',
        lastMessage: 'Você viu a nova atualização do Flutter?',
        timeAgo: '1 semana',
        isOnline: false,
      ),
    ];

    _isLoading = false;
    notifyListeners();
  }

  void updateSearch(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void openConversation(String id) {
    // Navigate to conversation
  }

  void goBack() {
    coordinator.pop();
  }

  void composeNewMessage() {
  }

  void onFilterTapped() {
  }
}
