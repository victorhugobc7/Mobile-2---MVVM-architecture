import 'package:flutter/material.dart';
import '../../shared/colors.dart';
import '../../shared/spacing.dart';
import 'create_post_bottom_bar_view_model.dart';

class CreatePostBottomBar extends StatelessWidget {
  final CreatePostBottomBarViewModel viewModel;

  const CreatePostBottomBar._({required this.viewModel});

  factory CreatePostBottomBar.instantiate({required CreatePostBottomBarViewModel viewModel}) {
    return CreatePostBottomBar._(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: small, vertical: doubleXS),
      decoration: const BoxDecoration(
        color: white,
        border: Border(top: BorderSide(color: gray_200)),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildMediaButton(
              icon: Icons.camera_alt_outlined,
              onPressed: viewModel.onCameraPressed,
            ),
            _buildMediaButton(
              icon: Icons.image_outlined,
              onPressed: viewModel.onImagePressed,
            ),
            _buildMediaButton(
              icon: Icons.videocam_outlined,
              onPressed: viewModel.onVideoPressed,
            ),
            _buildMediaButton(
              icon: Icons.attach_file,
              onPressed: viewModel.onDocumentPressed,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaButton({
    required IconData icon,
    VoidCallback? onPressed,
  }) {
    return IconButton(
      icon: Icon(icon, color: gray_600),
      onPressed: onPressed,
    );
  }
}
