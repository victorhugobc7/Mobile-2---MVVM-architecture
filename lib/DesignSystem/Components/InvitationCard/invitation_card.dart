import 'package:flutter/material.dart';
import 'invitation_card_view_model.dart';
import '../../shared/colors.dart';
import '../../shared/styles.dart';
import '../../shared/spacing.dart';

class InvitationCard extends StatelessWidget {
  final InvitationCardViewModel viewModel;

  const InvitationCard._({required this.viewModel});

  static Widget instantiate({required InvitationCardViewModel viewModel}) {
    return InvitationCard._(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: viewModel.onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: small, vertical: doubleXS),
        child: Row(
          children: [
            _buildAvatar(),
            SizedBox(width: extraSmall),
            Expanded(child: _buildInfo()),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 28,
      backgroundColor: navy_700,
      backgroundImage: viewModel.avatarUrl != null
          ? NetworkImage(viewModel.avatarUrl!)
          : null,
      child: viewModel.avatarUrl == null
          ? Text(
              viewModel.avatarInitials,
              style: labelTextStyle.copyWith(color: white),
            )
          : null,
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          viewModel.name,
          style: labelTextStyle.copyWith(color: primaryInk),
        ),
        Text(
          viewModel.title,
          style: label2Regular.copyWith(color: gray_600),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          viewModel.timeAgo,
          style: label2Regular.copyWith(color: gray_500, fontSize: 11),
        ),
      ],
    );
  }

  Widget _buildActions() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.close, color: gray_600),
          onPressed: viewModel.onDeclineTapped,
        ),
        ElevatedButton(
          onPressed: viewModel.onAcceptTapped,
          style: ElevatedButton.styleFrom(
            backgroundColor: blue_500,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: small, vertical: doubleXS),
          ),
          child: Text(
            'Aceitar',
            style: label2Regular.copyWith(color: white),
          ),
        ),
      ],
    );
  }
}
