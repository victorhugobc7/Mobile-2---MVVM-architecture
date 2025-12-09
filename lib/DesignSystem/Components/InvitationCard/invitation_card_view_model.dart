import 'package:flutter/material.dart';
import '../Buttons/ActionButton/action_button_view_model.dart';

abstract class InvitationCardDelegate {
  void onAcceptTapped(String id);
}

class InvitationCardViewModel {
  final String id;
  final String name;
  final String title;
  final String? avatarUrl;
  final String avatarInitials;
  final String timeAgo;
  final VoidCallback? onDeclineTapped;
  final VoidCallback? onTap;
  InvitationCardDelegate? delegate;

  late final ActionButtonViewModel acceptButtonViewModel = ActionButtonViewModel(
    size: ActionButtonSize.small,
    style: ActionButtonStyle.primary,
    text: 'Aceitar',
  );

  InvitationCardViewModel({
    required this.id,
    required this.name,
    required this.title,
    this.avatarUrl,
    required this.avatarInitials,
    required this.timeAgo,
    this.onDeclineTapped,
    this.onTap,
    this.delegate,
  }) {
    acceptButtonViewModel.delegate = _AcceptButtonDelegate(this);
  }
}

class _AcceptButtonDelegate implements ActionButtonDelegate {
  final InvitationCardViewModel viewModel;
  _AcceptButtonDelegate(this.viewModel);

  @override
  void buttonClicked() {
    viewModel.delegate?.onAcceptTapped(viewModel.id);
  }
}
