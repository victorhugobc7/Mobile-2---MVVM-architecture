import 'package:flutter/material.dart';
import 'text_button_view_model.dart';
import '../../../shared/colors.dart';
import '../../../shared/styles.dart';
import '../../../shared/spacing.dart';

class StyledTextButton extends StatefulWidget {
  final TextButtonViewModel viewModel;

  const StyledTextButton._({required this.viewModel});

  static Widget instantiate({required TextButtonViewModel viewModel}) {
    return StyledTextButton._(viewModel: viewModel);
  }

  @override
  State<StyledTextButton> createState() => _StyledTextButtonState();
}

class _StyledTextButtonState extends State<StyledTextButton> {
  bool _isHovered = false;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final vm = widget.viewModel;
    final textStyle = _getTextStyle();
    final color = vm.isEnabled ? blue_500 : gray_500;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: vm.isEnabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: Focus(
        onFocusChange: (focused) => setState(() => _isFocused = focused),
        child: GestureDetector(
          onTap: vm.isEnabled ? vm.onPressed : null,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: _isFocused ? doubleXS : 0,
              vertical: _isFocused ? tripleXS : 0,
            ),
            decoration: _isFocused
                ? BoxDecoration(
                    border: Border.all(color: blue_500, width: 1),
                    borderRadius: BorderRadius.circular(4),
                  )
                : null,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: _buildContent(vm, textStyle, color),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildContent(TextButtonViewModel vm, TextStyle textStyle, Color color) {
    final effectiveColor = _isHovered ? blue_600 : color;
    
    switch (vm.variant) {
      case TextButtonVariant.text:
        return [
          Text(
            vm.text,
            style: textStyle.copyWith(color: effectiveColor),
          ),
        ];

      case TextButtonVariant.caretRight:
        return [
          Text(
            vm.text,
            style: textStyle.copyWith(color: effectiveColor),
          ),
          SizedBox(width: tripleXS),
          Icon(
            _isHovered ? Icons.keyboard_double_arrow_right : Icons.chevron_right,
            size: vm.size == TextButtonSize.large ? 18 : 16,
            color: effectiveColor,
          ),
        ];

      case TextButtonVariant.caretLeft:
        return [
          Icon(
            _isHovered ? Icons.keyboard_double_arrow_left : Icons.chevron_left,
            size: vm.size == TextButtonSize.large ? 18 : 16,
            color: effectiveColor,
          ),
          SizedBox(width: tripleXS),
          Text(
            vm.text,
            style: textStyle.copyWith(color: effectiveColor),
          ),
        ];

      case TextButtonVariant.iconLeft:
        return [
          Icon(
            vm.icon ?? Icons.add_circle_outline,
            size: vm.size == TextButtonSize.large ? 18 : 16,
            color: effectiveColor,
          ),
          SizedBox(width: tripleXS),
          Text(
            vm.text,
            style: textStyle.copyWith(color: effectiveColor),
          ),
        ];
    }
  }

  TextStyle _getTextStyle() {
    switch (widget.viewModel.size) {
      case TextButtonSize.large:
        return bodyLarge.copyWith(fontWeight: FontWeight.w600);
      case TextButtonSize.small:
        return bodyRegular.copyWith(fontWeight: FontWeight.w600);
    }
  }
}
