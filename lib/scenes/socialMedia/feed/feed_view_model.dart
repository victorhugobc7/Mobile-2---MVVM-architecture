import 'package:flutter/material.dart';
import '../../../resources/shared/app_coordinator.dart';
import '../../../DesignSystem/Components/FeedAppBar/feed_app_bar_view_model.dart';
import '../../../DesignSystem/Components/CreatePostCard/create_post_card_view_model.dart';
import '../../../DesignSystem/Components/NavItem/nav_item_view_model.dart';
import 'feed_service.dart';

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
  final FeedService service;
  
  List<PostModel> _posts = [];
  bool _isLoading = false;
  String? _error;

  // Component ViewModels
  late final FeedAppBarViewModel appBarViewModel = FeedAppBarViewModel(
    logoAssetPath: 'lib/DesignSystem/Assets/ic_launcher_APP.svg',
    searchPlaceholder: 'Pesquisar',
    onSearchTapped: onSearchTapped,
    onMessagesTapped: goToMessages,
  );

  late final CreatePostCardViewModel createPostCardViewModel = CreatePostCardViewModel(
    avatarInitials: 'EU',
    placeholder: 'Começar publicação',
    onTap: goToCreatePost,
  );

  late final NavItemViewModel homeNavViewModel = NavItemViewModel(
    icon: Icons.home_filled,
    label: 'Início',
    isActive: true,
    onTap: () {}, // Handled by shell
  );

  late final NavItemViewModel networkNavViewModel = NavItemViewModel(
    icon: Icons.people_outline,
    label: 'Rede',
    onTap: () {}, // Handled by shell
  );

  late final NavItemViewModel postNavViewModel = NavItemViewModel(
    icon: Icons.add_box_outlined,
    label: 'Publicar',
    onTap: goToCreatePost,
  );

  late final NavItemViewModel notificationsNavViewModel = NavItemViewModel(
    icon: Icons.notifications_outlined,
    label: 'Notificações',
    onTap: () {}, // Handled by shell
  );

  late final NavItemViewModel jobsNavViewModel = NavItemViewModel(
    icon: Icons.work_outline,
    label: 'Vagas',
    onTap: () {}, // Handled by shell
  );

  FeedViewModel({required this.coordinator, required this.service}) {
    _loadPosts();
  }

  List<PostModel> get posts => _posts;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> _loadPosts() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      _posts = await service.fetchPosts();
      _error = null;
    } catch (e) {
      _error = 'Erro ao carregar posts';
    }
    
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

  }

  void onShareTapped(String postId) {
    
  }

  void onSendTapped(String postId) {
    
  }

  void onMoreOptionsTapped(String postId) {
    
  }

  void onSearchTapped() {
    
  }

  void goToProfile() {
    coordinator.goToProfile();
  }

  void goToMessages() {
    coordinator.goToMessages();
  }

  void goToCreatePost() {
    coordinator.goToCreatePost();
  }

  void logout() {
    coordinator.goToLogin();
  }

  void refreshFeed() {
    _loadPosts();
  }
}
