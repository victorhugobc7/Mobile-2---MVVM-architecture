import 'package:flutter/material.dart';
import 'search_bar_viewmodel.dart';

class SearchBar extends StatelessWidget {
  final SearchBarViewModel viewModel;

  const SearchBar({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: viewModel.controller,
      decoration: InputDecoration(
        hintText: viewModel.hint ?? 'Search...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: viewModel.controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: viewModel.onClear,
              )
            : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
