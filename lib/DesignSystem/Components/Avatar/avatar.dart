import 'package:flutter/material.dart';
import 'avatar_view_model.dart';
import '../../shared/colors.dart';
import '../../shared/styles.dart';

class Avatar extends StatelessWidget {
  final AvatarViewModel viewModel;

  const Avatar._({required this.viewModel});

  static Widget instantiate({required AvatarViewModel viewModel}) {
    return Avatar._(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: viewModel.onTap,
      child: Stack(
        children: [
          Container(
            width: viewModel.size,
            height: viewModel.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: navy_700,
              image: viewModel.imageUrl != null
                  ? DecorationImage(
                      image: NetworkImage(viewModel.imageUrl!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: viewModel.imageUrl == null
                ? Center(
                    child: Text(
                      viewModel.initials,
                      style: _getTextStyle(),
                    ),
                  )
                : null,
          ),
          if (viewModel.showOnlineIndicator && viewModel.isOnline)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: viewModel.size * 0.25,
                height: viewModel.size * 0.25,
                decoration: BoxDecoration(
                  color: green_confirmation,
                  shape: BoxShape.circle,
                  border: Border.all(color: white, width: 2),
                ),
              ),
            ),
        ],
      ),
    );
  }

  TextStyle _getTextStyle() {
    if (viewModel.size >= 80) {
      return title3.copyWith(color: white);
    } else if (viewModel.size >= 48) {
      return labelTextStyle.copyWith(color: white);
    } else {
      return label2Regular.copyWith(color: white, fontWeight: FontWeight.bold);
    }
  }
}
