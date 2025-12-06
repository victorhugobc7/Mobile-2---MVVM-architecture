import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../DesignSystem/shared/colors.dart';
import '../../../DesignSystem/shared/spacing.dart';
import '../../../DesignSystem/Components/CreatePostCard/create_post_card.dart';
import '../../../DesignSystem/Components/CreatePostCard/create_post_card_view_model.dart';
import '../../../DesignSystem/Components/PostCard/post_card.dart';
import '../../../DesignSystem/Components/PostCard/post_card_view_model.dart';
import '../../../DesignSystem/Components/NavItem/nav_item.dart';
import '../../../DesignSystem/Components/NavItem/nav_item_view_model.dart';
import '../../../DesignSystem/Components/FeedAppBar/feed_app_bar.dart';
import '../../../DesignSystem/Components/FeedAppBar/feed_app_bar_view_model.dart';
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
            appBar: FeedAppBar.instantiate(
              viewModel: FeedAppBarViewModel(
                logoAssetPath: 'lib/DesignSystem/Assets/ic_launcher_APP.svg',
                searchPlaceholder: 'Pesquisar',
                onSearchTapped: vm.onSearchTapped,
                onMessagesTapped: vm.goToMessages,
              ),
            ),
            body: vm.isLoading
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: () async => vm.refreshFeed(),
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: doubleXS),
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

  Widget _buildCreatePostCard(FeedViewModel vm) {
    return CreatePostCard.instantiate(
      viewModel: CreatePostCardViewModel(
        avatarInitials: 'EU',
        placeholder: 'Começar publicação',
        onTap: vm.goToCreatePost,
      ),
    );
  }

  Widget _buildPostCard(PostModel post, FeedViewModel vm) {
    return PostCard.instantiate(
      viewModel: PostCardViewModel(
        id: post.id,
        authorName: post.authorName,
        authorTitle: post.authorTitle,
        authorAvatar: post.authorAvatar,
        content: post.content,
        likes: post.likes,
        comments: post.comments,
        shares: post.shares,
        timeAgo: post.timeAgo,
        isLiked: post.isLiked,
        onLikeTapped: () => vm.toggleLike(post.id),
        onCommentTapped: () => vm.onCommentTapped(post.id),
        onShareTapped: () => vm.onShareTapped(post.id),
        onSendTapped: () => vm.onSendTapped(post.id),
        onMoreOptionsTapped: () => vm.onMoreOptionsTapped(post.id),
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
          padding: EdgeInsets.symmetric(vertical: doubleXS),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavItem.instantiate(
                viewModel: NavItemViewModel(
                  icon: Icons.home_filled,
                  label: 'Início',
                  isActive: true,
                  onTap: vm.onHomeTapped,
                ),
              ),
              NavItem.instantiate(
                viewModel: NavItemViewModel(
                  icon: Icons.people_outline,
                  label: 'Rede',
                  onTap: vm.goToNetwork,
                ),
              ),
              NavItem.instantiate(
                viewModel: NavItemViewModel(
                  icon: Icons.add_box_outlined,
                  label: 'Publicar',
                  onTap: vm.goToCreatePost,
                ),
              ),
              NavItem.instantiate(
                viewModel: NavItemViewModel(
                  icon: Icons.notifications_outlined,
                  label: 'Notificações',
                  onTap: vm.goToNotifications,
                ),
              ),
              NavItem.instantiate(
                viewModel: NavItemViewModel(
                  icon: Icons.work_outline,
                  label: 'Vagas',
                  onTap: vm.goToJobs,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
