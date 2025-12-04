import 'package:flutter/material.dart';
import '../../../resources/shared/app_coordinator.dart';

class CreatePostViewModel extends ChangeNotifier {
  final AppCoordinator coordinator;
  final TextEditingController contentController = TextEditingController();

  bool _isPosting = false;
  String? _selectedImage;
  bool _anyoneCanComment = true;

  CreatePostViewModel({required this.coordinator});

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
    // Simulate image selection
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

    // Simulate posting delay
    await Future.delayed(const Duration(seconds: 1));

    _isPosting = false;
    notifyListeners();

    // Go back to feed
    coordinator.pop();
  }

  void goBack() {
    coordinator.pop();
  }

  @override
  void dispose() {
    contentController.dispose();
    super.dispose();
  }
}
