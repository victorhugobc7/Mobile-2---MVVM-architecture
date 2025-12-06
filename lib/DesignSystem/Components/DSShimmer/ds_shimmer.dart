import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../shared/colors.dart';
import 'ds_shimmer_view_model.dart';

class DSShimmer extends StatelessWidget {
  final DSShimmerViewModel viewModel;

  const DSShimmer._({required this.viewModel});

  static Widget instantiate({required DSShimmerViewModel viewModel}) {
    return DSShimmer._(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: gray_200,
      highlightColor: gray_100,
      child: Container(
        width: viewModel.width,
        height: viewModel.height,
        decoration: BoxDecoration(
          color: gray_200,
          borderRadius: BorderRadius.circular(viewModel.borderRadius),
        ),
      ),
    );
  }
}
