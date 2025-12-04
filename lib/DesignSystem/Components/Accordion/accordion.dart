import 'package:flutter/material.dart';
import 'accordion_viewmodel.dart';
import '../../shared/colors.dart';

class Accordion extends StatefulWidget {
  final AccordionViewModel viewModel;

  const Accordion({super.key, required this.viewModel});

  @override
  State<Accordion> createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: white,
      child: ExpansionTile(
        title: Text(widget.viewModel.title),
        initiallyExpanded: widget.viewModel.isExpanded,
        onExpansionChanged: (expanded) {
          setState(() => widget.viewModel.isExpanded = expanded);
        },
        children: [
          Padding(padding: const EdgeInsets.all(8), child: widget.viewModel.content),
        ],
      ),
    );
  }
}
