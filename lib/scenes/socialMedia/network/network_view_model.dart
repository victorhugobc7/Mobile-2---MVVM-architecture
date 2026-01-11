import 'package:flutter/material.dart';
import '../../../resources/shared/app_coordinator.dart';
import '../../../DesignSystem/shared/colors.dart';
import '../../../DesignSystem/Components/SimpleAppBar/simple_app_bar_view_model.dart';
import '../../../DesignSystem/Components/StatCard/stat_card_view_model.dart';
import '../../../DesignSystem/Components/InvitationCard/invitation_card_view_model.dart';
import '../../../DesignSystem/Components/ConnectionCard/connection_card_view_model.dart';
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

class NetworkViewModel extends ChangeNotifier implements InvitationCardDelegate, ConnectionCardDelegate {
  final AppCoordinator coordinator;
  final NetworkService service;

  List<ConnectionModel> _suggestions = [];
  List<InvitationModel> _invitations = [];
  int _connectionsCount = 0;
  bool _isLoading = false;

  // Component ViewModels
  late final SimpleAppBarViewModel appBarViewModel = SimpleAppBarViewModel(
    title: 'Minha rede',
    actions: [
      IconButton(
        icon: const Icon(Icons.search, color: gray_600),
        onPressed: onSearchTapped,
      ),
    ],
  );

  List<StatCardViewModel> get statsViewModels => [
    StatCardViewModel(
      icon: Icons.people,
      value: _connectionsCount.toString(),
      label: 'Conexões',
    ),
    StatCardViewModel(
      icon: Icons.contacts,
      value: '124',
      label: 'Contatos',
    ),
    StatCardViewModel(
      icon: Icons.group_add,
      value: '89',
      label: 'Seguindo',
    ),
  ];

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

  @override
  void onConnectTapped(String id) {
    toggleConnection(id);
  }

  @override
  void onAcceptTapped(String id) {
    acceptInvitation(id);
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
