import 'package:flutter/material.dart';
import '../../shared/colors.dart';
import '../../shared/styles.dart';
import '../../shared/spacing.dart';
import 'search_bar_viewmodel.dart';

class DSSearchBar extends StatelessWidget {
  final SearchBarViewModel viewModel;

  const DSSearchBar._({required this.viewModel});

  static Widget instantiate({required SearchBarViewModel viewModel}) {
    return DSSearchBar._(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    if (viewModel.isReadOnly) {
      return GestureDetector(
        onTap: viewModel.onTap,
        child: Container(
          height: 36,
          decoration: BoxDecoration(
            color: gray_200,
            borderRadius: BorderRadius.zero,
          ),
          child: Row(
            children: [
              SizedBox(width: extraSmall),
              const Icon(Icons.search, color: gray_600, size: 20),
              SizedBox(width: doubleXS),
              Text(
                viewModel.placeholder,
                style: paragraph2Medium.copyWith(color: gray_600),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: gray_200,
        borderRadius: BorderRadius.zero,
      ),
      child: TextField(
        controller: viewModel.controller,
        onChanged: viewModel.onChanged,
        onSubmitted: viewModel.onSubmitted,
        style: paragraph2Medium.copyWith(color: primaryInk),
        decoration: InputDecoration(
          hintText: viewModel.placeholder,
          hintStyle: paragraph2Medium.copyWith(color: gray_600),
          prefixIcon: const Icon(Icons.search, color: gray_600, size: 20),
          suffixIcon: viewModel.controller != null && viewModel.controller!.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close, size: 18),
                  onPressed: viewModel.onClear,
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: extraSmall, vertical: doubleXS),
        ),
      ),
    );
  }
}
