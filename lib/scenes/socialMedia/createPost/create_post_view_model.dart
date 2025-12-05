import 'package:flutter/material.dart';
import '../../../resources/shared/app_coordinator.dart';
import 'create_post_service.dart';

class CreatePostViewModel extends ChangeNotifier {
  final AppCoordinator coordinator;
  final CreatePostService service;
  final TextEditingController contentController = TextEditingController();

  bool _isPosting = false;
  String? _selectedImage;
  bool _anyoneCanComment = true;

  CreatePostViewModel({required this.coordinator, required this.service});

  bool get isPosting => _isPosting;
  String? get selectedImage => _selectedImage;
  bool get anyoneCanComment => _anyoneCanComment;
  bool get canPost => contentController.text.trim().isNotEmpty;

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
