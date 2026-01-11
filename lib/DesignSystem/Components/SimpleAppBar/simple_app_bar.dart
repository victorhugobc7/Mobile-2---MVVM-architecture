import 'package:flutter/material.dart';
import '../../shared/colors.dart';
import '../../shared/styles.dart';
import 'simple_app_bar_view_model.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final SimpleAppBarViewModel viewModel;

  const SimpleAppBar._({required this.viewModel});

  factory SimpleAppBar.instantiate({required SimpleAppBarViewModel viewModel}) {
    return SimpleAppBar._(viewModel: viewModel);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: viewModel.backgroundColor ?? white,
      foregroundColor: viewModel.foregroundColor ?? primaryInk,
      elevation: viewModel.elevation ?? 0,
      centerTitle: viewModel.centerTitle,
      automaticallyImplyLeading: false,
      leading: viewModel.onBackPressed != null
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: viewModel.onBackPressed,
            )
          : null,
      title: Text(
        viewModel.title,
        style: title4.copyWith(
          color: viewModel.foregroundColor ?? primaryInk,
        ),
      ),
      actions: viewModel.actions,
    );
  }
}
