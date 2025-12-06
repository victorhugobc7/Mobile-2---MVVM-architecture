class CurrentUserModel {
  final String name;
  final String avatar;
  final String headline;

  CurrentUserModel({
    required this.name,
    required this.avatar,
    required this.headline,
  });
}

class CreatePostService {
  Future<CurrentUserModel> fetchCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return CurrentUserModel(
      name: 'Victor Hugo',
      avatar: 'VH',
      headline: 'Desenvolvedor Mobile | Flutter',
    );
  }

  Future<bool> createPost({
    required String content,
    String? imagePath,
    bool anyoneCanComment = true,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  Future<String?> uploadImage(String imagePath) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return 'https://example.com/images/post_image.jpg';
  }

  Future<bool> saveDraft({
    required String content,
    String? imagePath,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }

  Future<List<Map<String, dynamic>>> fetchDrafts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [];
  }

  Future<bool> deleteDraft(String draftId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }

  bool validateContent(String content) {
    return content.trim().isNotEmpty && content.length <= 3000;
  }

  Future<List<String>> getHashtagSuggestions(String query) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    final suggestions = [
      '#Flutter',
      '#Dart',
      '#MobileDev',
      '#TechBR',
      '#Desenvolvimento',
      '#Carreira',
      '#Vagas',
      '#Tecnologia',
    ];
    
    return suggestions
        .where((tag) => tag.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<List<Map<String, String>>> getMentionSuggestions(String query) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    return [
      {'name': 'Maria Silva', 'username': 'mariasilva'},
      {'name': 'João Santos', 'username': 'joaosantos'},
      {'name': 'Ana Costa', 'username': 'anacosta'},
    ].where((user) => 
      user['name']!.toLowerCase().contains(query.toLowerCase()) ||
      user['username']!.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }
}
