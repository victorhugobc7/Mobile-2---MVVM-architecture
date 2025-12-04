import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'action_card_view_model.dart';
import '../../../../resources/shared/colors.dart';
import '../../../../resources/shared/styles.dart';

class ActionCard extends StatelessWidget {
  final ActionCardViewModel viewModel;

  const ActionCard._({super.key, required this.viewModel});

  static Widget instantiate({required ActionCardViewModel viewModel}) {
    return ActionCard._(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    String title = viewModel.title;
    String content = viewModel.content;

    return Column(
      children: [
        Text(title, style: title4,),
        Text(content, style: bodyRegular,),
      ],
    );
  }
}