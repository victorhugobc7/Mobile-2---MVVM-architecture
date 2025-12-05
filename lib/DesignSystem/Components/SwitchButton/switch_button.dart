import 'package:flutter/material.dart';
import 'switch_button_viewmodel.dart';
import '../../shared/styles.dart';
import '../../shared/colors.dart';

class SwitchButton extends StatelessWidget {
  final SwitchButtonViewModel viewModel;

  const SwitchButton({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (viewModel.title != null)
          Text(viewModel.title!, style: labelTextStyle),
        Switch(value: viewModel.value, onChanged: viewModel.onChanged
        ,
        activeTrackColor: blue_500,
        trackColor: MaterialStateProperty.all(blue_500),
        inactiveThumbColor: Colors.white,
        inactiveTrackColor: Colors.transparent,
        ),
      ],
    );
  }
}
