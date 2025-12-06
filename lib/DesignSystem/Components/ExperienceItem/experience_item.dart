import 'package:flutter/material.dart';
import '../../shared/colors.dart';
import '../../shared/styles.dart';
import '../../shared/spacing.dart';
import 'experience_item_view_model.dart';

class ExperienceItem extends StatelessWidget {
  final ExperienceItemViewModel viewModel;

  const ExperienceItem._({required this.viewModel});

  static Widget instantiate({required ExperienceItemViewModel viewModel}) {
    return ExperienceItem._(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: viewModel.onTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: small),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLogo(),
            SizedBox(width: extraSmall),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    viewModel.title,
                    style: labelTextStyle.copyWith(color: primaryInk),
                  ),
                  Text(
                    viewModel.company,
                    style: label2Regular.copyWith(color: secondaryInk),
                  ),
                  Text(
                    viewModel.duration,
                    style: label2Regular.copyWith(color: gray_600),
                  ),
                  Text(
                    viewModel.location,
                    style: label2Regular.copyWith(color: gray_600),
                  ),
                  if (viewModel.description != null) ...[
                    SizedBox(height: doubleXS),
                    Text(
                      viewModel.description!,
                      style: label2Regular.copyWith(color: secondaryInk, fontSize: 13),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    if (viewModel.logoUrl != null) {
      return Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.network(
            viewModel.logoUrl!,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => _buildPlaceholder(),
          ),
        ),
      );
    }
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: gray_200,
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Icon(Icons.business, color: gray_600),
    );
  }
}
