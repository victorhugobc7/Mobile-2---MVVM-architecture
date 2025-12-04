import 'package:flutter/material.dart';
import '../../shared/colors.dart';
import 'checkbox_view_model.dart';
import '../../shared/styles.dart';

class CheckboxNew extends StatefulWidget {
  final CheckboxViewModel viewModel;
  /// Initial checked state. Defaults to false.
  final bool initialValue;
  /// If null, the checkbox will be disabled. Otherwise called when value changes.
  final ValueChanged<bool>? onChanged;

  const CheckboxNew({
    Key? key,
    required this.viewModel,
    this.initialValue = false,
    this.onChanged,
  }) : super(key: key);

  @override
  _CheckboxNewState createState() => _CheckboxNewState();
}

class _CheckboxNewState extends State<CheckboxNew> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.initialValue;
  }

  MaterialStateProperty<Color?> get _fillColor =>
      MaterialStateProperty.resolveWith((states) {
    // Disabled selected -> light gray; disabled unselected -> transparent
    if (states.contains(MaterialState.disabled)) {
      return _isChecked ? gray_300 : Colors.transparent;
    }
    // Selected -> primary blue (blue_500)
    if (states.contains(MaterialState.selected)) return blue_500;
    // Unselected -> white (transparent background)
    return white;
  });

  MaterialStateProperty<BorderSide?> get _side =>
      MaterialStateProperty.resolveWith((states) {
    if (states.contains(MaterialState.disabled)) {
      return BorderSide(color: gray_300, width: 1.5);
    }
    if (states.contains(MaterialState.focused)) {
      return BorderSide(color: blue_400, width: 2.0);
    }
    if (states.contains(MaterialState.selected)) {
      return BorderSide(color: blue_400, width: 1.5);
    }
    return BorderSide(color: gray_400, width: 1.5);
  });

  MaterialStateProperty<Color?> get _overlayColor =>
      MaterialStateProperty.resolveWith((states) {
    if (states.contains(MaterialState.pressed) || states.contains(MaterialState.focused)) {
      return blue_200.withOpacity(0.24);
    }
    return Colors.transparent;
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onChanged == null;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: isDisabled
              ? null
              : (bool? newValue) {
                  final val = newValue ?? false;
                  setState(() => _isChecked = val);
                  widget.onChanged?.call(val);
                },
          checkColor: Colors.white,
          fillColor: _fillColor,
          overlayColor: _overlayColor,
          // Resolve side for the current interactive state
          side: _side.resolve({
            if (isDisabled) MaterialState.disabled,
            if (_isChecked) MaterialState.selected,
          }),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        Text(widget.viewModel.title, style: labelTextStyle),
      ],
    );
  }
}