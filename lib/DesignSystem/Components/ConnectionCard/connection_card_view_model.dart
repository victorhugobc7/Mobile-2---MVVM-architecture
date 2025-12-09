import 'package:flutter/material.dart';
import '../Buttons/ActionButton/action_button_view_model.dart';

abstract class ConnectionCardDelegate {
  void onConnectTapped(String id);
}

class ConnectionCardViewModel {
  final String id;
  final String name;
  final String title;
  final String? avatarUrl;
  final String avatarInitials;
  final String? mutualConnections;
  final bool isConnected;
  final VoidCallback? onTap;
  ConnectionCardDelegate? delegate;

  late final ActionButtonViewModel connectButtonViewModel;

  ConnectionCardViewModel({
    required this.id,
    required this.name,
    required this.title,
    this.avatarUrl,
    required this.avatarInitials,
    this.mutualConnections,
    this.isConnected = false,
    this.onTap,
    this.delegate,
  }) {
    connectButtonViewModel = ActionButtonViewModel(
      size: ActionButtonSize.small,
      style: isConnected ? ActionButtonStyle.outlineSuccess : ActionButtonStyle.outline,
      text: isConnected ? 'Pendente' : 'Conectar',
    );
    connectButtonViewModel.delegate = _ConnectButtonDelegate(this);
  }
}

class _ConnectButtonDelegate implements ActionButtonDelegate {
  final ConnectionCardViewModel viewModel;
  _ConnectButtonDelegate(this.viewModel);

  @override
  void buttonClicked() {
    viewModel.delegate?.onConnectTapped(viewModel.id);
  }
}
