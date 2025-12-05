import 'package:flutter/material.dart';
import 'connection_card_view_model.dart';
import '../../shared/colors.dart';
import '../../shared/styles.dart';
import '../../shared/spacing.dart';

class ConnectionCard extends StatelessWidget {
  final ConnectionCardViewModel viewModel;

  const ConnectionCard._({required this.viewModel});

  static Widget instantiate({required ConnectionCardViewModel viewModel}) {
    return ConnectionCard._(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: viewModel.onTap,
      child: Container(
        width: 160,
        margin: EdgeInsets.symmetric(horizontal: doubleXS),
        decoration: BoxDecoration(
          color: white,
          border: Border.all(color: gray_300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            _buildHeader(),
            Transform.translate(
              offset: const Offset(0, -30),
              child: _buildContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: blue_200,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        _buildAvatar(),
        SizedBox(height: doubleXS),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: doubleXS),
          child: Text(
            viewModel.name,
            style: labelTextStyle.copyWith(color: primaryInk),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: doubleXS),
          child: Text(
            viewModel.title,
            style: label2Regular.copyWith(color: gray_600),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (viewModel.mutualConnections != null) ...[
          SizedBox(height: tripleXS),
          Text(
            viewModel.mutualConnections!,
            style: label2Regular.copyWith(color: gray_500, fontSize: 10),
          ),
        ],
        SizedBox(height: extraSmall),
        _buildConnectButton(),
      ],
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 36,
      backgroundColor: navy_700,
      backgroundImage: viewModel.avatarUrl != null
          ? NetworkImage(viewModel.avatarUrl!)
          : null,
      child: viewModel.avatarUrl == null
          ? Text(
              viewModel.avatarInitials,
              style: bodyLarge.copyWith(color: white, fontWeight: FontWeight.bold),
            )
          : null,
    );
  }

  Widget _buildConnectButton() {
    final isConnected = viewModel.isConnected;
    return OutlinedButton(
      onPressed: viewModel.onConnectTapped,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: isConnected ? green_confirmation : blue_500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: medium, vertical: tripleXS),
      ),
      child: Text(
        isConnected ? 'Pendente' : 'Conectar',
        style: label2Regular.copyWith(
          color: isConnected ? green_confirmation : blue_500,
        ),
      ),
    );
  }
}
