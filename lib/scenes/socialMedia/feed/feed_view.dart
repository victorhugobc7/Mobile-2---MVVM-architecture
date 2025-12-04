import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../DesignSystem/shared/colors.dart';
import '../../../DesignSystem/shared/styles.dart';
import '../../../DesignSystem/shared/spacing.dart';
import '../../../DesignSystem/Components/BaseProfile/base_profile.dart';
import '../../../DesignSystem/Components/BaseProfile/base_profile_view_model.dart';
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

  AppBar _buildAppBar(FeedViewModel vm) {
    return AppBar(
      backgroundColor: white,
      elevation: 1,
      leading: Padding(
        padding: EdgeInsets.all(extraSmall),
        child: SvgPicture.asset(
          'lib/DesignSystem/Assets/ic_launcher_APP.svg',
          width: 40,
          height: 40,
        ),
      ),
      title: GestureDetector(
        onTap: vm.onSearchTapped,
        child: Container(
          height: 36,
          decoration: BoxDecoration(
            color: gray_200,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              SizedBox(width: extraSmall),
              Icon(Icons.search, color: gray_600, size: 20),
              SizedBox(width: doubleXS),
              Text(
                'Pesquisar',
                style: paragraph2Medium.copyWith(color: gray_600),
              ),
            ],
          ),
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
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: tripleXS),
      padding: EdgeInsets.all(small),
      color: white,
      child: Row(
        children: [
          _buildAvatar('EU'),
          SizedBox(width: extraSmall),
          Expanded(
            child: GestureDetector(
              onTap: vm.goToCreatePost,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: small, vertical: extraSmall),
                decoration: BoxDecoration(
                  border: Border.all(color: gray_400),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  'Começar publicação',
                  style: paragraph2Medium.copyWith(color: gray_600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(String initials) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: gray_200,
        border: Border.all(color: gray_300, width: 1),
      ),
      child: Center(
        child: Text(
          initials,
          style: labelTextStyle.copyWith(color: gray_600),
        ),
      ),
    );
  }

  Widget _buildPostCard(PostModel post, FeedViewModel vm) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: tripleXS),
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(small),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: BaseProfile.instantiate(
                    viewModel: BaseProfileViewModel(
                      name: post.authorName,
                      company: post.authorTitle.split(' na ').length > 1 
                          ? post.authorTitle.split(' na ')[1] 
                          : '',
                      title: post.authorTitle.split(' na ')[0],
                      avatarInitials: post.authorAvatar,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_horiz, color: gray_600),
                  onPressed: () => vm.onMoreOptionsTapped(post.id),
                ),
              ],
            ),
          ),
          
          Padding(
            padding: EdgeInsets.symmetric(horizontal: small),
            child: Text(
              post.timeAgo,
              style: label2Regular.copyWith(color: gray_600),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: small),
            child: Text(
              post.content,
              style: paragraph2Medium.copyWith(color: primaryInk, height: 1.4),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(small),
            child: Row(
              children: [
                Icon(
                  Icons.thumb_up,
                  size: 16,
                  color: blue_500,
                ),
                SizedBox(width: tripleXS),
                Text(
                  '${post.likes + (post.isLiked ? 1 : 0)}',
                  style: label2Regular.copyWith(color: gray_600),
                ),
                const Spacer(),
                Text(
                  '${post.comments} comentários • ${post.shares} compartilhamentos',
                  style: label2Regular.copyWith(color: gray_600),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          Padding(
            padding: EdgeInsets.symmetric(vertical: tripleXS),
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
                  onTap: () => vm.onCommentTapped(post.id),
                ),
                _buildActionButton(
                  icon: Icons.share_outlined,
                  label: 'Compartilhar',
                  onTap: () => vm.onShareTapped(post.id),
                ),
                _buildActionButton(
                  icon: Icons.send_outlined,
                  label: 'Enviar',
                  onTap: () => vm.onSendTapped(post.id),
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
        padding: EdgeInsets.symmetric(vertical: extraSmall, horizontal: doubleXS),
        child: Column(
          children: [
            Icon(
              icon,
              size: 20,
              color: isActive ? blue_500 : gray_600,
            ),
            SizedBox(height: tripleXS),
            Text(
              label,
              style: label2Regular.copyWith(color: isActive ? blue_500 : gray_600),
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
          padding: EdgeInsets.symmetric(vertical: doubleXS),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home_filled,
                label: 'Início',
                isActive: true,
                onTap: vm.onHomeTapped,
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
          SizedBox(height: tripleXS),
          Text(
            label,
            style: label2Regular.copyWith(color: isActive ? primaryInk : gray_600),
          ),
        ],
      ),
    );
  }
}
