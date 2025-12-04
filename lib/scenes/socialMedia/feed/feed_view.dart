import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../resources/shared/colors.dart';
import 'feed_view_model.dart';

class FeedView extends StatelessWidget {
  final FeedViewModel viewModel;

  const FeedView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<FeedViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: gray_200,
            appBar: _buildAppBar(vm),
            body: vm.isLoading
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: () async => vm.refreshFeed(),
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: vm.posts.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return _buildCreatePostCard(vm);
                        }
                        return _buildPostCard(vm.posts[index - 1], vm);
                      },
                    ),
                  ),
            bottomNavigationBar: _buildBottomNav(vm),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(FeedViewModel vm) {
    return AppBar(
      backgroundColor: white,
      elevation: 1,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: blue_500,
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Center(
            child: Text(
              'BS',
              style: TextStyle(
                color: white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      title: Container(
        height: 36,
        decoration: BoxDecoration(
          color: gray_200,
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Row(
          children: [
            SizedBox(width: 12),
            Icon(Icons.search, color: gray_600, size: 20),
            SizedBox(width: 8),
            Text(
              'Pesquisar',
              style: TextStyle(color: gray_600, fontSize: 14),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.message_outlined, color: gray_600),
          onPressed: vm.goToMessages,
        ),
      ],
    );
  }

  Widget _buildCreatePostCard(FeedViewModel vm) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      padding: const EdgeInsets.all(16),
      color: white,
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: blue_500,
            child: const Text(
              'EU',
              style: TextStyle(color: white, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: vm.goToCreatePost,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: gray_400),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Text(
                  'Começar publicação',
                  style: TextStyle(color: gray_600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostCard(PostModel post, FeedViewModel vm) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: navy_700,
                  child: Text(
                    post.authorAvatar,
                    style: const TextStyle(
                      color: white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.authorName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: primaryInk,
                        ),
                      ),
                      Text(
                        post.authorTitle,
                        style: const TextStyle(
                          fontSize: 12,
                          color: gray_600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        post.timeAgo,
                        style: const TextStyle(
                          fontSize: 12,
                          color: gray_600,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_horiz, color: gray_600),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              post.content,
              style: const TextStyle(
                fontSize: 14,
                color: primaryInk,
                height: 1.4,
              ),
            ),
          ),

          // Stats
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  Icons.thumb_up,
                  size: 16,
                  color: blue_500,
                ),
                const SizedBox(width: 4),
                Text(
                  '${post.likes + (post.isLiked ? 1 : 0)}',
                  style: const TextStyle(fontSize: 12, color: gray_600),
                ),
                const Spacer(),
                Text(
                  '${post.comments} comentários • ${post.shares} compartilhamentos',
                  style: const TextStyle(fontSize: 12, color: gray_600),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Actions
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(
                  icon: post.isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                  label: 'Gostei',
                  isActive: post.isLiked,
                  onTap: () => vm.toggleLike(post.id),
                ),
                _buildActionButton(
                  icon: Icons.comment_outlined,
                  label: 'Comentar',
                  onTap: () {},
                ),
                _buildActionButton(
                  icon: Icons.share_outlined,
                  label: 'Compartilhar',
                  onTap: () {},
                ),
                _buildActionButton(
                  icon: Icons.send_outlined,
                  label: 'Enviar',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    bool isActive = false,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          children: [
            Icon(
              icon,
              size: 20,
              color: isActive ? blue_500 : gray_600,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isActive ? blue_500 : gray_600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav(FeedViewModel vm) {
    return Container(
      decoration: const BoxDecoration(
        color: white,
        border: Border(top: BorderSide(color: gray_300)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home_filled,
                label: 'Início',
                isActive: true,
                onTap: () {},
              ),
              _buildNavItem(
                icon: Icons.people_outline,
                label: 'Rede',
                onTap: vm.goToNetwork,
              ),
              _buildNavItem(
                icon: Icons.add_box_outlined,
                label: 'Publicar',
                onTap: vm.goToCreatePost,
              ),
              _buildNavItem(
                icon: Icons.notifications_outlined,
                label: 'Notificações',
                onTap: vm.goToNotifications,
              ),
              _buildNavItem(
                icon: Icons.work_outline,
                label: 'Vagas',
                onTap: vm.goToJobs,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    bool isActive = false,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? primaryInk : gray_600,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isActive ? primaryInk : gray_600,
            ),
          ),
        ],
      ),
    );
  }
}
