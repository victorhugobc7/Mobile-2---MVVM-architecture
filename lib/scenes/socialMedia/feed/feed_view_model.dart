import 'package:flutter/material.dart';
import '../../../resources/shared/app_coordinator.dart';
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
