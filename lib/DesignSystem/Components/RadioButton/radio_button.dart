import 'package:flutter/material.dart';
import 'radio_button_viewmodel.dart';
import '../../shared/colors.dart';

class RadioButton<T> extends StatefulWidget {
  final RadioButtonViewModel<T> viewModel;

  const RadioButton({super.key, required this.viewModel});

  @override
  State<RadioButton<T>> createState() => _RadioButtonState<T>();
}

class _RadioButtonState<T> extends State<RadioButton<T>> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final vm = widget.viewModel;
    final isDisabled = vm.isDisabled;

    return MouseRegion(
  onEnter: (_) => setState(() => _isHovered = true),
  onExit:  (_) => setState(() => _isHovered = false),
  child: GestureDetector(
    behavior: HitTestBehavior.translucent, // <-- catch taps on the whole row
    onTap: isDisabled
        ? null
        : () {
            widget.viewModel.onChanged(widget.viewModel.value);
            setState(() {}); // <-- ensure visual updates immediately
          },
    child: Padding( // optional: bigger tap target
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 2.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // (hover halo + radio visuals exactly as in the last version)
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: _isHovered && !widget.viewModel.isDisabled
                ? const EdgeInsets.all(2)
                : EdgeInsets.zero,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: _isHovered && !widget.viewModel.isDisabled
                  ? Border.all(color: blue_400, width: 2)
                  : null,
            ),
            child: _buildRadioCircle(), // your 20x20 circle with inner 10px blue_500 dot
          ),
          if (widget.viewModel.title != null) ...[
            const SizedBox(width: 8),
            Text(
              widget.viewModel.title!,
              style: TextStyle(
                color: widget.viewModel.isDisabled ? gray_500 : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    ),
  ),
);

  }
  Widget _buildRadioCircle() {
  final vm = widget.viewModel;
  final isSelected = vm.isSelected;
  final isDisabled = vm.isDisabled;
  final ringColor = isDisabled ? gray_500 : (isSelected ? blue_500 : Colors.black54);

  return Container(
    width: 20,
    height: 20,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: ringColor, width: 2),
    ),
    child: Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: isSelected ? 10 : 0,
        height: isSelected ? 10 : 0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDisabled
              ? gray_500
              : (isSelected ? blue_500 : Colors.transparent),
        ),
      ),
    ),
  );
}
}