import 'package:flutter/material.dart';

class ConnectionCardViewModel {
  final String id;
  final String name;
  final String title;
  final String? avatarUrl;
  final String avatarInitials;
  final String? mutualConnections;
  final bool isConnected;
  final VoidCallback? onConnectTapped;
  final VoidCallback? onTap;

  ConnectionCardViewModel({
    required this.id,
    required this.name,
    required this.title,
    this.avatarUrl,
    required this.avatarInitials,
    this.mutualConnections,
    this.isConnected = false,
    this.onConnectTapped,
    this.onTap,
  });
}
