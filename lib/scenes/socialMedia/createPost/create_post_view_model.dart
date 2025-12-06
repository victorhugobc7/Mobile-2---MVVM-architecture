import 'package:flutter/material.dart';
import '../../../resources/shared/app_coordinator.dart';
import 'create_post_service.dart';

class CreatePostViewModel extends ChangeNotifier {
  final AppCoordinator coordinator;
  final CreatePostService service;
  final TextEditingController contentController = TextEditingController();

  bool _isLoading = true;
  bool _isPosting = false;
  String? _selectedImage;
  bool _anyoneCanComment = true;
  CurrentUserModel? _currentUser;

  CreatePostViewModel({required this.coordinator, required this.service}) {
    _loadCurrentUser();
  }

  bool get isLoading => _isLoading;
  bool get isPosting => _isPosting;
  String? get selectedImage => _selectedImage;
  bool get anyoneCanComment => _anyoneCanComment;
  bool get canPost => contentController.text.trim().isNotEmpty;
  CurrentUserModel? get currentUser => _currentUser;

  String get userName => _currentUser?.name ?? '';
  String get userAvatar => _currentUser?.avatar ?? '';

  Future<void> _loadCurrentUser() async {
    _isLoading = true;
    notifyListeners();

    try {
      _currentUser = await service.fetchCurrentUser();
    } catch (e) {
      // Handle error
    }

    _isLoading = false;
    notifyListeners();
  }

  void updateContent() {
    notifyListeners();
  }

  void setAnyoneCanComment(bool value) {
    _anyoneCanComment = value;
    notifyListeners();
  }

  void selectImage() {
    _selectedImage = 'selected_image.jpg';
    notifyListeners();
  }

  void removeImage() {
    _selectedImage = null;
    notifyListeners();
  }

  Future<void> submitPost() async {
    if (!canPost) return;

    _isPosting = true;
    notifyListeners();

    try {
      await service.createPost(
        content: contentController.text,
        imagePath: _selectedImage,
        anyoneCanComment: _anyoneCanComment,
      );
    } catch (e) {
      // Handle error
    }

    _isPosting = false;
    notifyListeners();

    coordinator.pop();
  }

  void goBack() {
    coordinator.pop();
  }

  void onAddVideoTapped() {
  }

  void onAddEventTapped() {
  }

  void onAddArticleTapped() {
  }

  @override
  void dispose() {
    contentController.dispose();
    super.dispose();
  }
}
