import 'package:flutter/material.dart';
import 'dropdown_form_viewmodel.dart';
import '../../shared/colors.dart';

// Define your color palette (replace with your own constants if available)

// Provide a nullable hintText getter for DropdownFormViewModel<T> so existing usages compile
extension DropdownFormViewModelHintExtension<T> on DropdownFormViewModel<T> {
  String? get hintText => null;
}

class DropdownFormField<T> extends StatefulWidget {
  final DropdownFormViewModel<T> viewModel;

  const DropdownFormField({super.key, required this.viewModel});

  @override
  State<DropdownFormField<T>> createState() => _DropdownFormFieldState<T>();
}

class _DropdownFormFieldState<T> extends State<DropdownFormField<T>> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: blue_500,
        borderRadius: BorderRadius.circular(0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: widget.viewModel.selectedItem,
          icon: Container(
            padding: const EdgeInsets.all(0),
            decoration: const BoxDecoration(
              color: blue_700,
              borderRadius: BorderRadius.all(Radius.circular(0)),
            ),
            child: const Icon(Icons.keyboard_arrow_down, color: white),
          ),
          dropdownColor: white,
          isExpanded: true,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
          hint: Text(
            widget.viewModel.hintText ?? 'Select an option',
            style: const TextStyle(color: Colors.white),
          ),
          onChanged: widget.viewModel.onChanged,
          items: widget.viewModel.items.map((item) {
            final bool isSelected = item == widget.viewModel.selectedItem;
            final bool isHovered = item == widget.viewModel.items.first; // mimic hover style for Option 1
            return DropdownMenuItem<T>(
              value: item,
              child: Container(
                decoration: BoxDecoration(
                  color: isHovered
                      ? blue_500.withOpacity(0.1)
                      : Colors.transparent,
                  border: isHovered
                      ? const Border(
                          left: BorderSide(color: blue_500, width: 3),
                        )
                      : null,
                ),
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                child: Text(
                  item.toString(),
                  style: TextStyle(
                    color: isSelected || isHovered ? blue_500 : Colors.black87,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
