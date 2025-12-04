import 'network_view_model.dart';

class NetworkService {
  Future<List<ConnectionModel>> fetchSuggestions() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      ConnectionModel(
        id: '1',
        name: 'Lucas Ferreira',
        title: 'Tech Lead na Amazon',
        avatar: 'LF',
        mutualConnections: '15 conexões em comum',
      ),
      ConnectionModel(
        id: '2',
        name: 'Juliana Alves',
        title: 'Product Designer na Spotify',
        avatar: 'JA',
        mutualConnections: '8 conexões em comum',
      ),
      ConnectionModel(
        id: '3',
        name: 'Ricardo Santos',
        title: 'Backend Developer na Netflix',
        avatar: 'RS',
        mutualConnections: '23 conexões em comum',
      ),
      ConnectionModel(
        id: '4',
        name: 'Camila Rocha',
        title: 'Engineering Manager na Meta',
        avatar: 'CR',
        mutualConnections: '12 conexões em comum',
      ),
    ];
  }

  Future<List<InvitationModel>> fetchInvitations() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return [
      InvitationModel(
        id: '1',
        name: 'Carlos Mendes',
        title: 'Engenheiro de Software na Google',
        avatar: 'CM',
        timeAgo: '2 dias',
      ),
      InvitationModel(
        id: '2',
        name: 'Fernanda Lima',
        title: 'Data Scientist na Microsoft',
        avatar: 'FL',
        timeAgo: '5 dias',
      ),
    ];
  }

  Future<int> getConnectionsCount() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return 487;
  }

  Future<bool> sendConnectionRequest(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }

  Future<bool> acceptInvitation(String invitationId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Future<bool> declineInvitation(String invitationId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Future<bool> removeConnection(String connectionId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }
}
