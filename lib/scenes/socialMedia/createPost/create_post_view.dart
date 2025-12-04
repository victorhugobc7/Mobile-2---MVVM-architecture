import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../resources/shared/colors.dart';
import 'create_post_view_model.dart';

class CreatePostView extends StatelessWidget {
  final CreatePostViewModel viewModel;

  const CreatePostView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<CreatePostViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: white,
            appBar: AppBar(
              backgroundColor: white,
              elevation: 1,
              leading: IconButton(
                icon: const Icon(Icons.close, color: primaryInk),
                onPressed: vm.goBack,
              ),
              title: const Text(
                'Criar publicação',
                style: TextStyle(
                  color: primaryInk,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: TextButton(
                    onPressed: vm.canPost && !vm.isPosting ? vm.submitPost : null,
                    style: TextButton.styleFrom(
                      backgroundColor: vm.canPost ? blue_500 : gray_300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    child: vm.isPosting
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: white,
                            ),
                          )
                        : Text(
                            'Publicar',
                            style: TextStyle(
                              color: vm.canPost ? white : gray_500,
                            ),
                          ),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildUserHeader(),
                        _buildContentInput(vm),
                        if (vm.selectedImage != null) _buildImagePreview(vm),
                      ],
                    ),
                  ),
                ),
                _buildBottomBar(vm),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildUserHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundColor: navy_700,
            child: Text(
              'VH',
              style: TextStyle(
                color: white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Victor Hugo',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: primaryInk,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: gray_400),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.public, size: 14, color: gray_600),
                    SizedBox(width: 4),
                    Text(
                      'Qualquer pessoa',
                      style: TextStyle(fontSize: 12, color: gray_600),
                    ),
                    Icon(Icons.arrow_drop_down, size: 16, color: gray_600),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContentInput(CreatePostViewModel vm) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: vm.contentController,
        onChanged: (_) => vm.updateContent(),
        maxLines: null,
        minLines: 5,
        decoration: const InputDecoration(
          hintText: 'Sobre o que você quer falar?',
          hintStyle: TextStyle(
            color: gray_500,
            fontSize: 16,
          ),
          border: InputBorder.none,
        ),
        style: const TextStyle(
          fontSize: 16,
          color: primaryInk,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildImagePreview(CreatePostViewModel vm) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: gray_200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Icon(
                Icons.image,
                size: 64,
                color: gray_400,
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: vm.removeImage,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: primaryInk,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  color: white,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(CreatePostViewModel vm) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: white,
        border: Border(top: BorderSide(color: gray_300)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                _buildToolButton(
                  icon: Icons.image,
                  label: 'Foto',
                  onTap: vm.selectImage,
                ),
                _buildToolButton(
                  icon: Icons.videocam,
                  label: 'Vídeo',
                  onTap: () {},
                ),
                _buildToolButton(
                  icon: Icons.event,
                  label: 'Evento',
                  onTap: () {},
                ),
                _buildToolButton(
                  icon: Icons.article,
                  label: 'Artigo',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.chat_bubble_outline, size: 20, color: gray_600),
                const SizedBox(width: 8),
                const Text(
                  'Qualquer pessoa pode comentar',
                  style: TextStyle(fontSize: 14, color: gray_600),
                ),
                const Spacer(),
                Switch(
                  value: vm.anyoneCanComment,
                  onChanged: vm.setAnyoneCanComment,
                  activeColor: blue_500,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              Icon(icon, color: gray_600, size: 24),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  color: gray_600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
