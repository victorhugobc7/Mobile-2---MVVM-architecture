import 'package:flutter/material.dart';
import '../../../resources/shared/app_coordinator.dart';

class PostModel {
  final String id;
  final String authorName;
  final String authorTitle;
  final String authorAvatar;
  final String content;
  final String? imageUrl;
  final int likes;
  final int comments;
  final int shares;
  final String timeAgo;
  bool isLiked;

  PostModel({
    required this.id,
    required this.authorName,
    required this.authorTitle,
    required this.authorAvatar,
    required this.content,
    this.imageUrl,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.timeAgo,
    this.isLiked = false,
  });
}

class FeedViewModel extends ChangeNotifier {
  final AppCoordinator coordinator;
  
  List<PostModel> _posts = [];
  bool _isLoading = false;
  String? _error;

  FeedViewModel({required this.coordinator}) {
    _loadPosts();
  }

  List<PostModel> get posts => _posts;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void _loadPosts() {
    _isLoading = true;
    notifyListeners();

    // Simulated posts data
    _posts = [
      PostModel(
        id: '1',
        authorName: 'Maria Silva',
        authorTitle: 'Desenvolvedora Senior na Tech Corp',
        authorAvatar: 'MS',
        content: '🚀 Acabei de concluir minha certificação em Flutter! Muito feliz com essa conquista. A jornada foi desafiadora, mas valeu cada momento de dedicação.\n\n#Flutter #Desenvolvimento #Carreira',
        likes: 234,
        comments: 45,
        shares: 12,
        timeAgo: '2h',
      ),
      PostModel(
        id: '2',
        authorName: 'João Santos',
        authorTitle: 'Product Manager na StartupXYZ',
        authorAvatar: 'JS',
        content: 'Dica de carreira: Nunca pare de aprender! O mercado de tecnologia está em constante evolução e quem não se atualiza fica para trás.\n\nQuais cursos vocês estão fazendo atualmente?',
        likes: 567,
        comments: 89,
        shares: 34,
        timeAgo: '4h',
      ),
      PostModel(
        id: '3',
        authorName: 'Ana Costa',
        authorTitle: 'UX Designer na DesignStudio',
        authorAvatar: 'AC',
        content: 'Estamos contratando! 🎨\n\nProcuramos designers talentosos para integrar nossa equipe. Se você tem paixão por criar experiências incríveis, venha fazer parte do nosso time!\n\n#Vagas #UXDesign #Emprego',
        likes: 890,
        comments: 156,
        shares: 78,
        timeAgo: '6h',
      ),
      PostModel(
        id: '4',
        authorName: 'Pedro Oliveira',
        authorTitle: 'CEO na InovaTech',
        authorAvatar: 'PO',
        content: 'Reflexão do dia: O sucesso não é sobre onde você está, mas sobre a direção que você está seguindo. Continue evoluindo! 💪',
        likes: 1234,
        comments: 203,
        shares: 89,
        timeAgo: '8h',
      ),
    ];

    _isLoading = false;
    notifyListeners();
  }

  void toggleLike(String postId) {
    final index = _posts.indexWhere((p) => p.id == postId);
    if (index != -1) {
      _posts[index].isLiked = !_posts[index].isLiked;
      notifyListeners();
    }
  }

  void onCommentTapped(String postId) {
    // TODO: Navigate to comments or open comment sheet
  }

  void onShareTapped(String postId) {
    // TODO: Open share options
  }

  void onSendTapped(String postId) {
    // TODO: Open send/message dialog
  }

  void onMoreOptionsTapped(String postId) {
    // TODO: Show more options menu
  }

  void onSearchTapped() {
    // TODO: Navigate to search screen
  }

  void onHomeTapped() {
    // Already on feed, no action needed
  }

  void goToProfile() {
    coordinator.goToProfile();
  }

  void goToNetwork() {
    coordinator.goToNetwork();
  }

  void goToMessages() {
    coordinator.goToMessages();
  }

  void goToNotifications() {
    coordinator.goToNotifications();
  }

  void goToCreatePost() {
    coordinator.goToCreatePost();
  }

  void goToJobs() {
    coordinator.goToJobs();
  }

  void logout() {
    coordinator.goToLogin();
  }

  void refreshFeed() {
    _loadPosts();
  }
}
