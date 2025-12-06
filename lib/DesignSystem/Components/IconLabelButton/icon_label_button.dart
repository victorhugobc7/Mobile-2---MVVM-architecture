import 'package:flutter/material.dart';
import '../../shared/colors.dart';
import '../../shared/styles.dart';
import '../../shared/spacing.dart';
import 'icon_label_button_view_model.dart';

class IconLabelButton extends StatelessWidget {
  final IconLabelButtonViewModel viewModel;

  const IconLabelButton._({required this.viewModel});

  static Widget instantiate({required IconLabelButtonViewModel viewModel}) {
    return IconLabelButton._(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: viewModel.onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: extraSmall, horizontal: doubleXS),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              viewModel.icon,
              size: 20,
              color: viewModel.isActive ? blue_500 : gray_600,
            ),
            SizedBox(height: tripleXS),
            Text(
              viewModel.label,
              style: label2Regular.copyWith(
                color: viewModel.isActive ? blue_500 : gray_600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
