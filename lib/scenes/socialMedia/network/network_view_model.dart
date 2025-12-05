import 'package:flutter/material.dart';
import '../../../resources/shared/app_coordinator.dart';
import 'network_service.dart';

class ConnectionModel {
  final String id;
  final String name;
  final String title;
  final String avatar;
  final String mutualConnections;
  bool isConnected;

  ConnectionModel({
    required this.id,
    required this.name,
    required this.title,
    required this.avatar,
    required this.mutualConnections,
    this.isConnected = false,
  });
}

class InvitationModel {
  final String id;
  final String name;
  final String title;
  final String avatar;
  final String timeAgo;

  InvitationModel({
    required this.id,
    required this.name,
    required this.title,
    required this.avatar,
    required this.timeAgo,
  });
}

class NetworkViewModel extends ChangeNotifier {
  final AppCoordinator coordinator;
  final NetworkService service;

  List<ConnectionModel> _suggestions = [];
  List<InvitationModel> _invitations = [];
  int _connectionsCount = 0;
  bool _isLoading = false;

  NetworkViewModel({required this.coordinator, required this.service}) {
    _loadData();
  }

  List<ConnectionModel> get suggestions => _suggestions;
  List<InvitationModel> get invitations => _invitations;
  int get connectionsCount => _connectionsCount;
  bool get isLoading => _isLoading;

  Future<void> _loadData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _suggestions = await service.fetchSuggestions();
      _invitations = await service.fetchInvitations();
      _connectionsCount = await service.getConnectionsCount();
    } catch (e) {
      // Handle error
    }

    _isLoading = false;
    notifyListeners();
  }

  void toggleConnection(String id) {
    final index = _suggestions.indexWhere((c) => c.id == id);
    if (index != -1) {
      _suggestions[index].isConnected = !_suggestions[index].isConnected;
      notifyListeners();
    }
  }

  void acceptInvitation(String id) {
    _invitations.removeWhere((i) => i.id == id);
    _connectionsCount++;
    notifyListeners();
  }

  void declineInvitation(String id) {
    _invitations.removeWhere((i) => i.id == id);
    notifyListeners();
  }

  void goBack() {
    coordinator.pop();
  }

  void goToFeed() {
    coordinator.pop();
  }

  void onSearchTapped() {
  }

  void onViewAllInvitationsTapped() {
  }
}
