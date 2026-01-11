import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../DesignSystem/shared/colors.dart';
import '../../../DesignSystem/shared/styles.dart';
import '../../../DesignSystem/shared/spacing.dart';
import '../../../DesignSystem/Components/StatCard/stat_card.dart';
import '../../../DesignSystem/Components/ConnectionCard/connection_card.dart';
import '../../../DesignSystem/Components/ConnectionCard/connection_card_view_model.dart';
import '../../../DesignSystem/Components/InvitationCard/invitation_card.dart';
import '../../../DesignSystem/Components/InvitationCard/invitation_card_view_model.dart';
import '../../../DesignSystem/Components/SectionHeader/section_header.dart';
import '../../../DesignSystem/Components/SectionHeader/section_header_view_model.dart';
import '../../../DesignSystem/Components/SimpleAppBar/simple_app_bar.dart';
import 'network_view_model.dart';

class NetworkView extends StatelessWidget {
  final NetworkViewModel viewModel;
  final bool showBottomNav;

  const NetworkView({super.key, required this.viewModel, this.showBottomNav = true});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<NetworkViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: gray_200,
            appBar: SimpleAppBar.instantiate(viewModel: vm.appBarViewModel),
            body: vm.isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildStatsSection(vm),
                        if (vm.invitations.isNotEmpty) _buildInvitationsSection(vm),
                        _buildSuggestionsSection(vm),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildStatsSection(NetworkViewModel vm) {
    return StatCardRow.instantiate(stats: vm.statsViewModels);
  }

  Widget _buildInvitationsSection(NetworkViewModel vm) {
    return Container(
      margin: EdgeInsets.only(top: doubleXS),
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader.instantiate(
            viewModel: SectionHeaderViewModel(
              title: 'Convites (${vm.invitations.length})',
              actionText: 'Ver todos',
              onActionTapped: vm.onViewAllInvitationsTapped,
            ),
          ),
          ...vm.invitations.map((invitation) => InvitationCard.instantiate(
            viewModel: InvitationCardViewModel(
              id: invitation.id,
              name: invitation.name,
              title: invitation.title,
              avatarInitials: invitation.avatar,
              timeAgo: invitation.timeAgo,
              onDeclineTapped: () => vm.declineInvitation(invitation.id),
              delegate: vm,
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildSuggestionsSection(NetworkViewModel vm) {
    return Container(
      margin: EdgeInsets.only(top: doubleXS),
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(small),
            child: Text(
              'Pessoas que você talvez conheça',
              style: labelTextStyle.copyWith(color: primaryInk, fontSize: 16),
            ),
          ),
          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: doubleXS),
              itemCount: vm.suggestions.length,
              itemBuilder: (context, index) {
                final connection = vm.suggestions[index];
                return ConnectionCard.instantiate(
                  viewModel: ConnectionCardViewModel(
                    id: connection.id,
                    name: connection.name,
                    title: connection.title,
                    avatarInitials: connection.avatar,
                    mutualConnections: connection.mutualConnections,
                    isConnected: connection.isConnected,
                    delegate: vm,
                  ),
                );
              },
            ),
          ),
          SizedBox(height: small),
        ],
      ),
    );
  }
}
