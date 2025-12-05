import 'package:flutter/material.dart';
import '../../../resources/shared/app_coordinator.dart';
import 'messages_service.dart';

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
  final MessagesService service;

  List<MessageModel> _messages = [];
  bool _isLoading = false;
  String _searchQuery = '';

  MessagesViewModel({required this.coordinator, required this.service}) {
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

  Future<void> _loadMessages() async {
    _isLoading = true;
    notifyListeners();

    try {
      _messages = await service.fetchConversations();
    } catch (e) {
      // Handle error
    }

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
