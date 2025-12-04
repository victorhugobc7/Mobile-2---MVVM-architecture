import 'package:flutter/material.dart';
import 'pill_viewmodel.dart';
import '../../shared/colors.dart';

class Pill extends StatelessWidget {
  final PillViewModel viewModel;

  const Pill({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {

    Color selectedColor;
    Color textColor;
  switch (viewModel.style) {
    case PillStyle.Primary:
    selectedColor = blue_200;
    textColor = blue_700;
    break;
    case PillStyle.Secondary:
    selectedColor = navy_700;
    textColor = white;
    break;
    case PillStyle.Secondary_Light:
    selectedColor = navy_300;
    textColor = navy_800;
    break;
    case PillStyle.Gray:
    selectedColor = tertiaryInk;
    textColor = white;
    break;
    case PillStyle.Gray_Light:
    selectedColor = gray_600;
    textColor = white;
    break;
    case PillStyle.Tertiary:
    selectedColor = mint_dark;
    textColor = white;
    break;
    case PillStyle.Tertiary_Light:
    selectedColor = mint_light;
    textColor = mint_dark;
    break;
    case PillStyle.Positive:
    selectedColor = green_confirmation;
    textColor = white;
    break;
    case PillStyle.Positive_Light:
    selectedColor = green_light;
    textColor = mint_dark;
    break;
    case PillStyle.Warning:
    selectedColor = yellow_marigold;
    textColor = yellow_dark;
    break;
    case PillStyle.Warning_Light:
    selectedColor = yellow_light;
    textColor = yellow_dark;
    break;
    case PillStyle.Negative:
    selectedColor = red_error;
    textColor = white;
    break;
    case PillStyle.Negative_Light:
    selectedColor = red_light;
    textColor = red_dark;
    break;
    default:
    selectedColor = blue_500;
    textColor = white;
}
    return GestureDetector(
      onTap: viewModel.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
                  color: selectedColor,
                  borderRadius: BorderRadius.circular(50),
                ),
        child: Text(
          viewModel.label,
          style: TextStyle(
            color: textColor,
          ),
          ),
        ),
      );
  }
}

