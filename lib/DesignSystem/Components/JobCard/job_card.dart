import 'package:flutter/material.dart';
import '../../shared/colors.dart';
import '../../shared/styles.dart';
import '../../shared/spacing.dart';
import '../Tag/tag.dart';
import '../Tag/tag_view_model.dart';
import 'job_card_view_model.dart';

class JobCard extends StatelessWidget {
  final JobCardViewModel viewModel;

  const JobCard._({required this.viewModel});

  static Widget instantiate({required JobCardViewModel viewModel}) {
    return JobCard._(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: small),
      child: InkWell(
        onTap: viewModel.onTap,
        child: Padding(
          padding: EdgeInsets.all(small),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: doubleXS),
              _buildCompanyInfo(),
              SizedBox(height: doubleXS),
              _buildLocationAndSalary(),
              SizedBox(height: doubleXS),
              _buildTags(),
              SizedBox(height: doubleXS),
              _buildPostedTime(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: gray_200,
            borderRadius: BorderRadius.circular(doubleXS),
          ),
          child: const Icon(Icons.business, color: gray_600),
        ),
        SizedBox(width: extraSmall),
        Expanded(
          child: Text(
            viewModel.title,
            style: title3.copyWith(color: primaryInk),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(
          icon: Icon(
            viewModel.isSaved ? Icons.bookmark : Icons.bookmark_border,
            color: viewModel.isSaved ? blue_500 : gray_600,
          ),
          onPressed: viewModel.onSaveTapped,
        ),
      ],
    );
  }

  Widget _buildCompanyInfo() {
    return Padding(
      padding: EdgeInsets.only(left: 48 + extraSmall),
      child: Text(
        viewModel.company,
        style: labelTextStyle.copyWith(color: primaryInk),
      ),
    );
  }

  Widget _buildLocationAndSalary() {
    return Padding(
      padding: EdgeInsets.only(left: 48 + extraSmall),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 16, color: gray_600),
              SizedBox(width: tripleXS),
              Expanded(
                child: Text(
                  viewModel.location,
                  style: label2Regular.copyWith(color: gray_600),
                ),
              ),
            ],
          ),
          if (viewModel.salary.isNotEmpty) ...[
            SizedBox(height: tripleXS),
            Row(
              children: [
                const Icon(Icons.attach_money, size: 16, color: gray_600),
                SizedBox(width: tripleXS),
                Text(
                  viewModel.salary,
                  style: label2Regular.copyWith(color: gray_600),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTags() {
    if (viewModel.tags.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(left: 48 + extraSmall),
      child: Wrap(
        spacing: doubleXS,
        runSpacing: tripleXS,
        children: viewModel.tags
            .map((tag) => Tag.instantiate(
                  viewModel: TagViewModel(text: tag, color: blue_500),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildPostedTime() {
    return Padding(
      padding: EdgeInsets.only(left: 48 + extraSmall),
      child: Text(
        viewModel.postedTime,
        style: label2Regular.copyWith(color: gray_600),
      ),
    );
  }
}
