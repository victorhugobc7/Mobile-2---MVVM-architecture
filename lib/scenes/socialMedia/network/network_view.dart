import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../resources/shared/colors.dart';
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
            appBar: AppBar(
              backgroundColor: white,
              elevation: 1,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: primaryInk),
                onPressed: vm.goBack,
              ),
              title: const Text(
                'Minha rede',
                style: TextStyle(
                  color: primaryInk,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search, color: gray_600),
                  onPressed: () {},
                ),
              ],
            ),
            body: vm.isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildStatsCard(vm),
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

  Widget _buildStatsCard(NetworkViewModel vm) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      color: white,
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              icon: Icons.people,
              label: 'Conexões',
              value: vm.connectionsCount.toString(),
            ),
          ),
          Container(width: 1, height: 40, color: gray_300),
          Expanded(
            child: _buildStatItem(
              icon: Icons.contacts,
              label: 'Contatos',
              value: '124',
            ),
          ),
          Container(width: 1, height: 40, color: gray_300),
          Expanded(
            child: _buildStatItem(
              icon: Icons.group_add,
              label: 'Seguindo',
              value: '89',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: gray_600, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primaryInk,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: gray_600,
          ),
        ),
      ],
    );
  }

  Widget _buildInvitationsSection(NetworkViewModel vm) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Convites (${vm.invitations.length})',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryInk,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Ver todos',
                    style: TextStyle(color: blue_500),
                  ),
                ),
              ],
            ),
          ),
          ...vm.invitations.map((invitation) => _buildInvitationItem(invitation, vm)),
        ],
      ),
    );
  }

  Widget _buildInvitationItem(InvitationModel invitation, NetworkViewModel vm) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: navy_700,
            child: Text(
              invitation.avatar,
              style: const TextStyle(
                color: white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  invitation.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: primaryInk,
                  ),
                ),
                Text(
                  invitation.title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: gray_600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  invitation.timeAgo,
                  style: const TextStyle(
                    fontSize: 11,
                    color: gray_500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: gray_600),
            onPressed: () => vm.declineInvitation(invitation.id),
          ),
          ElevatedButton(
            onPressed: () => vm.acceptInvitation(invitation.id),
            style: ElevatedButton.styleFrom(
              backgroundColor: blue_500,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: const Text(
              'Aceitar',
              style: TextStyle(color: white, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionsSection(NetworkViewModel vm) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Pessoas que você talvez conheça',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryInk,
              ),
            ),
          ),
          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: vm.suggestions.length,
              itemBuilder: (context, index) {
                return _buildSuggestionCard(vm.suggestions[index], vm);
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSuggestionCard(ConnectionModel connection, NetworkViewModel vm) {
    return Container(
      width: 160,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: white,
        border: Border.all(color: gray_300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            height: 60,
            decoration: const BoxDecoration(
              color: blue_200,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -30),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: navy_700,
                  child: Text(
                    connection.avatar,
                    style: const TextStyle(
                      color: white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    connection.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: primaryInk,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    connection.title,
                    style: const TextStyle(
                      fontSize: 11,
                      color: gray_600,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  connection.mutualConnections,
                  style: const TextStyle(
                    fontSize: 10,
                    color: gray_500,
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () => vm.toggleConnection(connection.id),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: connection.isConnected ? green_confirmation : blue_500,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                  ),
                  child: Text(
                    connection.isConnected ? 'Pendente' : 'Conectar',
                    style: TextStyle(
                      color: connection.isConnected ? green_confirmation : blue_500,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
