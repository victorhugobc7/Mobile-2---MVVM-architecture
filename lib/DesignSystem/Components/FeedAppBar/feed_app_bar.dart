import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../shared/colors.dart';
import '../../shared/spacing.dart';
import '../SearchBar/search_bar.dart';
import '../SearchBar/search_bar_viewmodel.dart';
import 'feed_app_bar_view_model.dart';

class FeedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final FeedAppBarViewModel viewModel;

  const FeedAppBar._({required this.viewModel});

  static PreferredSizeWidget instantiate({required FeedAppBarViewModel viewModel}) {
    return FeedAppBar._(viewModel: viewModel);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: white,
      elevation: 1,
      leading: _buildLogo(),
      title: DSSearchBar.instantiate(
        viewModel: SearchBarViewModel(
          placeholder: viewModel.searchPlaceholder,
          isReadOnly: true,
          onTap: viewModel.onSearchTapped,
        ),
      ),
      actions: [
        if (viewModel.onMessagesTapped != null)
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.message_outlined, color: gray_600),
                onPressed: viewModel.onMessagesTapped,
              ),
              if (viewModel.unreadMessagesCount != null && viewModel.unreadMessagesCount! > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: red_error,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      viewModel.unreadMessagesCount! > 9 ? '9+' : '${viewModel.unreadMessagesCount}',
                      style: const TextStyle(
                        color: white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        if (viewModel.additionalActions != null) ...viewModel.additionalActions!,
      ],
    );
  }

  Widget _buildLogo() {
    if (viewModel.logoAssetPath != null) {
      return Padding(
        padding: EdgeInsets.all(extraSmall),
        child: SvgPicture.asset(
          viewModel.logoAssetPath!,
          width: 40,
          height: 40,
          placeholderBuilder: (context) => _buildLogoPlaceholder(),
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.all(extraSmall),
      child: _buildLogoPlaceholder(),
    );
  }

  Widget _buildLogoPlaceholder() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: blue_500,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.work, color: white, size: 24),
    );
  }
}
