import 'package:flutter/material.dart';
import 'stat_card_view_model.dart';
import '../../shared/colors.dart';
import '../../shared/styles.dart';
import '../../shared/spacing.dart';

class StatCard extends StatelessWidget {
  final StatCardViewModel viewModel;

  const StatCard._({required this.viewModel});

  static Widget instantiate({required StatCardViewModel viewModel}) {
    return StatCard._(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: viewModel.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(viewModel.icon, color: gray_600, size: 24),
          SizedBox(height: tripleXS),
          Text(
            viewModel.value,
            style: title4.copyWith(color: primaryInk),
          ),
          Text(
            viewModel.label,
            style: label2Regular.copyWith(color: gray_600),
          ),
        ],
      ),
    );
  }
}

class StatCardRow extends StatelessWidget {
  final List<StatCardViewModel> stats;

  const StatCardRow._({required this.stats});

  static Widget instantiate({required List<StatCardViewModel> stats}) {
    return StatCardRow._(stats: stats);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: doubleXS),
      padding: EdgeInsets.all(small),
      color: white,
      child: Row(
        children: stats.asMap().entries.map((entry) {
          final index = entry.key;
          final stat = entry.value;
          return Expanded(
            child: Row(
              children: [
                if (index > 0)
                  Container(width: 1, height: 40, color: gray_300),
                Expanded(child: StatCard.instantiate(viewModel: stat)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
