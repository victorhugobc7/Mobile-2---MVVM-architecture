import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../DesignSystem/shared/colors.dart';
import '../../../DesignSystem/shared/styles.dart';
import '../../../DesignSystem/shared/spacing.dart';
import '../../../DesignSystem/Components/StatCard/stat_card.dart';
import '../../../DesignSystem/Components/StatCard/stat_card_view_model.dart';
import '../../../DesignSystem/Components/ConnectionCard/connection_card.dart';
import '../../../DesignSystem/Components/ConnectionCard/connection_card_view_model.dart';
import '../../../DesignSystem/Components/InvitationCard/invitation_card.dart';
import '../../../DesignSystem/Components/InvitationCard/invitation_card_view_model.dart';
import '../../../DesignSystem/Components/SectionHeader/section_header.dart';
import '../../../DesignSystem/Components/SectionHeader/section_header_view_model.dart';
import 'network_view_model.dart';

class NetworkView extends StatelessWidget {
  final NetworkViewModel viewModel;

  const NetworkView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<NetworkViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: gray_200,
            appBar: _buildAppBar(vm),
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

  AppBar _buildAppBar(NetworkViewModel vm) {
    return AppBar(
      backgroundColor: white,
      elevation: 1,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: primaryInk),
        onPressed: vm.goBack,
      ),
      title: Text(
        'Minha rede',
        style: labelTextStyle.copyWith(color: primaryInk, fontSize: 18),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: gray_600),
          onPressed: vm.onSearchTapped,
        ),
      ],
    );
  }

  Widget _buildStatsSection(NetworkViewModel vm) {
    return StatCardRow.instantiate(
      stats: [
        StatCardViewModel(
          icon: Icons.people,
          value: vm.connectionsCount.toString(),
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
      ],
    );
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
              onAcceptTapped: () => vm.acceptInvitation(invitation.id),
              onDeclineTapped: () => vm.declineInvitation(invitation.id),
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
                    onConnectTapped: () => vm.toggleConnection(connection.id),
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
