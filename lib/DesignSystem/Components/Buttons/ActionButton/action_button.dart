import 'package:flutter/material.dart';
import 'action_button_view_model.dart';
import '../../../../resources/shared/colors.dart';
import '../../../../resources/shared/styles.dart';
import '../../../../resources/shared/spacing.dart';

class ActionButton extends StatelessWidget {
  final ActionButtonViewModel viewModel;

  const ActionButton._({super.key, required this.viewModel});

  static Widget instantiate({required ActionButtonViewModel viewModel}) {
    return ActionButton._(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    double horizontalPadding = large;
    double verticalPadding = small;
    double iconSize = large;
    TextStyle buttonTextStyle = buttonStyle;
    Color buttonColor = blue_400;
    Color iconBackgroundColor = blue_700;

    switch (viewModel.size) {
      case ActionButtonSize.large:
        buttonTextStyle = buttonStyle;
        iconSize = large;
        break;
      case ActionButtonSize.medium:
        buttonTextStyle = buttonStyle;
        iconSize = large;
        break;
      case ActionButtonSize.small:
        buttonTextStyle = buttonStyle;
        horizontalPadding = 16;
        iconSize = small;
        break;
    }

    switch (viewModel.style) {
      case ActionButtonStyle.primary:
        buttonColor = blue_400;
        iconBackgroundColor = blue_700;
        break;
      case ActionButtonStyle.secondary:
        buttonColor = navy_700;
        iconBackgroundColor = navy_700;
        break;
      case ActionButtonStyle.tertiary:
        buttonColor = mint_dark;
        iconBackgroundColor = mint_dark;
        break;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
                  onPressed: viewModel.onPressed,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      textStyle: buttonTextStyle,
                      padding: EdgeInsets.symmetric(
                          vertical: verticalPadding,
                          horizontal: horizontalPadding
                          ),
                      ),
                  child: Text(viewModel.text, style: buttonTextStyle,)
                  ),
          Stack(
              children: [
                Container(
                  width: iconSize,
                  height: iconSize,
                  color: iconBackgroundColor,
                  padding: EdgeInsets.symmetric(
                      vertical: verticalPadding,
                      horizontal: horizontalPadding
                  ),
                ),
                Icon(
                  viewModel.icon,
                  size: iconSize,
                  color: white,
                ),
              ]
          ),
    ]
    );


      /* ElevatedButton(
      onPressed: viewModel.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        textStyle: buttonTextStyle,
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: horizontalPadding
        )
      ),
      child: viewModel.icon !=null ?
      Row(
        children: [
          Stack(
            children: [
              Container(width: iconSize, height: iconSize, color: iconBackgroundColor,),
              Icon(
                viewModel.icon,
                size: iconSize,
                color: white,
              ),
            ],
          ),
          Text(viewModel.text, style: buttonTextStyle,)
        ],
      ) :
      Text(viewModel.text, style: buttonTextStyle),
    );
  }


       */
  }
}