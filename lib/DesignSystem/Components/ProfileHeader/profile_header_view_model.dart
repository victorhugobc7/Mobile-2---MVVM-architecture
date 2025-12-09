import 'package:flutter/material.dart';
import '../Buttons/ActionButton/action_button_view_model.dart';

abstract class ProfileHeaderDelegate {
  void onConnectPressed();
  void onAddSectionPressed();
}

class ProfileHeaderViewModel extends ChangeNotifier {
  final String name;
  final String headline;
  final String location;
  final String avatar;
  final int connections;
  final bool isEditing;
  final VoidCallback? onSharePressed;
  final VoidCallback? onEditToggle;
  ProfileHeaderDelegate? delegate;

  late final ActionButtonViewModel connectButtonViewModel = ActionButtonViewModel(
    size: ActionButtonSize.medium,
    style: ActionButtonStyle.primary,
    text: 'Aberto a',
  );

  late final ActionButtonViewModel addSectionButtonViewModel = ActionButtonViewModel(
    size: ActionButtonSize.medium,
    style: ActionButtonStyle.outline,
    text: 'Adicionar seção',
  );

  ProfileHeaderViewModel({
    required this.name,
    required this.headline,
    required this.location,
    required this.avatar,
    required this.connections,
    this.isEditing = false,
    this.onSharePressed,
    this.onEditToggle,
    this.delegate,
  }) {
    connectButtonViewModel.delegate = _ConnectButtonDelegate(this);
    addSectionButtonViewModel.delegate = _AddSectionButtonDelegate(this);
  }
}

class _ConnectButtonDelegate implements ActionButtonDelegate {
  final ProfileHeaderViewModel viewModel;
  _ConnectButtonDelegate(this.viewModel);

  @override
  void buttonClicked() {
    viewModel.delegate?.onConnectPressed();
  }
}

class _AddSectionButtonDelegate implements ActionButtonDelegate {
  final ProfileHeaderViewModel viewModel;
  _AddSectionButtonDelegate(this.viewModel);

  @override
  void buttonClicked() {
    viewModel.delegate?.onAddSectionPressed();
  }
}
