import 'package:flutter/material.dart';
import '../../../resources/shared/app_coordinator.dart';

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

  List<ConnectionModel> _suggestions = [];
  List<InvitationModel> _invitations = [];
  int _connectionsCount = 0;
  bool _isLoading = false;

  NetworkViewModel({required this.coordinator}) {
    _loadData();
  }

  List<ConnectionModel> get suggestions => _suggestions;
  List<InvitationModel> get invitations => _invitations;
  int get connectionsCount => _connectionsCount;
  bool get isLoading => _isLoading;

  void _loadData() {
    _isLoading = true;
    notifyListeners();

    _connectionsCount = 487;

    _invitations = [
      InvitationModel(
        id: '1',
        name: 'Carlos Mendes',
        title: 'Engenheiro de Software na Google',
        avatar: 'CM',
        timeAgo: '2 dias',
      ),
      InvitationModel(
        id: '2',
        name: 'Fernanda Lima',
        title: 'Data Scientist na Microsoft',
        avatar: 'FL',
        timeAgo: '5 dias',
      ),
    ];

    _suggestions = [
      ConnectionModel(
        id: '1',
        name: 'Roberto Alves',
        title: 'Tech Lead na Amazon',
        avatar: 'RA',
        mutualConnections: '15 conexões em comum',
      ),
      ConnectionModel(
        id: '2',
        name: 'Juliana Ferreira',
        title: 'Product Designer na Nubank',
        avatar: 'JF',
        mutualConnections: '23 conexões em comum',
      ),
      ConnectionModel(
        id: '3',
        name: 'Marcos Paulo',
        title: 'Backend Developer na Itaú',
        avatar: 'MP',
        mutualConnections: '8 conexões em comum',
      ),
      ConnectionModel(
        id: '4',
        name: 'Beatriz Santos',
        title: 'Mobile Developer na iFood',
        avatar: 'BS',
        mutualConnections: '12 conexões em comum',
      ),
      ConnectionModel(
        id: '5',
        name: 'Lucas Ribeiro',
        title: 'DevOps Engineer na Mercado Livre',
        avatar: 'LR',
        mutualConnections: '19 conexões em comum',
      ),
      ConnectionModel(
        id: '6',
        name: 'Amanda Costa',
        title: 'Frontend Developer na Globo',
        avatar: 'AC',
        mutualConnections: '7 conexões em comum',
      ),
    ];

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
