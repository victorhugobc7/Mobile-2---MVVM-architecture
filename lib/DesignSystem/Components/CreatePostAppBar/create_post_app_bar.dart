import 'package:flutter/material.dart';
import '../../shared/colors.dart';
import '../../shared/styles.dart';
import '../../shared/spacing.dart';
import 'create_post_app_bar_view_model.dart';

class CreatePostAppBar extends StatelessWidget implements PreferredSizeWidget {
  final CreatePostAppBarViewModel viewModel;

  const CreatePostAppBar._({required this.viewModel});

  factory CreatePostAppBar.instantiate({required CreatePostAppBarViewModel viewModel}) {
    return CreatePostAppBar._(viewModel: viewModel);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.close, color: primaryInk),
        onPressed: viewModel.onBackPressed ?? () => Navigator.of(context).pop(),
      ),
      title: Text(
        'Criar publicação',
        style: title4.copyWith(color: primaryInk),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: small),
          child: viewModel.isPosting
              ? const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              : TextButton(
                  onPressed: viewModel.isPostEnabled ? viewModel.onPostPressed : null,
                  child: Text(
                    'Publicar',
                    style: labelTextStyle.copyWith(
                      color: viewModel.isPostEnabled ? blue_500 : gray_400,
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
