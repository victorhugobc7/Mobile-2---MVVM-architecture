import 'package:flutter/material.dart';
import '../../shared/colors.dart';
import '../../shared/styles.dart';
import '../../shared/spacing.dart';
import '../BaseProfile/base_profile.dart';
import '../BaseProfile/base_profile_view_model.dart';
import '../IconLabelButton/icon_label_button.dart';
import '../IconLabelButton/icon_label_button_view_model.dart';
import 'post_card_view_model.dart';

class PostCard extends StatelessWidget {
  final PostCardViewModel viewModel;

  const PostCard._({required this.viewModel});

  static Widget instantiate({required PostCardViewModel viewModel}) {
    return PostCard._(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: tripleXS),
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildTimeAgo(),
          _buildContent(),
          if (viewModel.imageUrl != null) _buildImage(),
          _buildStats(),
          const Divider(height: 1),
          _buildActions(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final titleParts = viewModel.authorTitle.split(' na ');
    return Padding(
      padding: EdgeInsets.all(small),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: BaseProfile.instantiate(
              viewModel: BaseProfileViewModel(
                name: viewModel.authorName,
                company: titleParts.length > 1 ? titleParts[1] : '',
                title: titleParts[0],
                avatarInitials: viewModel.authorAvatar,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz, color: gray_600),
            onPressed: viewModel.onMoreOptionsTapped,
          ),
        ],
      ),
    );
  }

  Widget _buildTimeAgo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: small),
      child: Text(
        viewModel.timeAgo,
        style: label2Regular.copyWith(color: gray_600),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: small),
      child: Text(
        viewModel.content,
        style: paragraph2Medium.copyWith(color: primaryInk, height: 1.4),
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      margin: EdgeInsets.only(top: small),
      width: double.infinity,
      height: 200,
      color: gray_200,
      child: Image.network(
        viewModel.imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Center(
          child: Icon(Icons.image, size: 48, color: gray_400),
        ),
      ),
    );
  }

  Widget _buildStats() {
    final displayLikes = viewModel.likes + (viewModel.isLiked ? 1 : 0);
    return Padding(
      padding: EdgeInsets.all(small),
      child: Row(
        children: [
          const Icon(Icons.thumb_up, size: 16, color: blue_500),
          SizedBox(width: tripleXS),
          Text(
            '$displayLikes',
            style: label2Regular.copyWith(color: gray_600),
          ),
          const Spacer(),
          Text(
            '${viewModel.comments} comentários • ${viewModel.shares} compartilhamentos',
            style: label2Regular.copyWith(color: gray_600),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: tripleXS),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconLabelButton.instantiate(
            viewModel: IconLabelButtonViewModel(
              icon: viewModel.isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
              label: 'Gostei',
              isActive: viewModel.isLiked,
              onTap: viewModel.onLikeTapped,
            ),
          ),
          IconLabelButton.instantiate(
            viewModel: IconLabelButtonViewModel(
              icon: Icons.comment_outlined,
              label: 'Comentar',
              onTap: viewModel.onCommentTapped,
            ),
          ),
          IconLabelButton.instantiate(
            viewModel: IconLabelButtonViewModel(
              icon: Icons.share_outlined,
              label: 'Compartilhar',
              onTap: viewModel.onShareTapped,
            ),
          ),
          IconLabelButton.instantiate(
            viewModel: IconLabelButtonViewModel(
              icon: Icons.send_outlined,
              label: 'Enviar',
              onTap: viewModel.onSendTapped,
            ),
          ),
        ],
      ),
    );
  }
}
