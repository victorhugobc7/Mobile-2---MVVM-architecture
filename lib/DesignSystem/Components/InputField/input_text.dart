import 'package:flutter/material.dart';
import '../../../resources/shared/colors.dart';
import '../../../resources/shared/spacing.dart';
import '../../../../resources/shared/styles.dart';
import 'input_text_view_model.dart';

class StyledInputField extends StatefulWidget {
  final InputTextViewModel viewModel;

  const StyledInputField._({Key? key, required this.viewModel}) : super(key: key);

  @override
  StyledInputFieldState createState() => StyledInputFieldState();

  static Widget instantiate({required InputTextViewModel viewModel}) {

    Widget titleWidget = viewModel.title?.isNotEmpty == true
        ? Padding(
        padding: const EdgeInsets.only(bottom: extraSmall),
        child: Text(viewModel.title as String, style: labelTextStyle)
    )
        : const SizedBox.shrink();

    Widget inputField = StyledInputField._(viewModel: viewModel);

    // Return a Column to stack title on top of input field
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        titleWidget,
        inputField,
      ],
    );
  }
}

class TitleField extends State<StyledInputField>{

  @override
  Widget build(BuildContext context) {

    Widget titleWidget = widget.viewModel.title?.isNotEmpty == true ?
      Text(widget.viewModel.title as String, style: labelTextStyle)
          :
      SizedBox();

    return titleWidget;
    }
  }

class StyledInputFieldState extends State<StyledInputField> {
  late bool obscureText;
  String? errorMsg;

  @override
  void initState() {
    super.initState();
    obscureText = widget.viewModel.password;
    widget.viewModel.controller.addListener(validateInput);
  }

  void validateInput() {
    final errorText = widget.viewModel.validator?.call(widget.viewModel.controller.text);
    setState(() {
      errorMsg = errorText;
    });
  }

  void togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  void dispose() {
    widget.viewModel.controller.removeListener(validateInput);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    InputDecoration decoration = InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: extraSmall, horizontal: 24),
      filled: true,
      suffixIcon: widget.viewModel.password
          ? IconButton(
              icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
              onPressed: togglePasswordVisibility,
            )
          : widget.viewModel.suffixIcon,
      fillColor: widget.viewModel.isEnabled ? white : gray_100,
      hintText: widget.viewModel.placeholder.isNotEmpty ? widget.viewModel.placeholder : null,
      hintStyle: labelTextStyle.copyWith(color: gray_500),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: const BorderSide(color: gray_600),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: const BorderSide(color: red_error),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: const BorderSide(color: blue_500),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: const BorderSide(color: gray_600),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: const BorderSide(color: gray_500),
      ),
      errorText: errorMsg,
    );


    return TextFormField(
      controller: widget.viewModel.controller,
      obscureText: obscureText,
      decoration: decoration,
      style: labelTextStyle,
      enabled: widget.viewModel.isEnabled,
    );
  }
}
