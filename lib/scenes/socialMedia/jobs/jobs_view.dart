import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../DesignSystem/shared/colors.dart';
import '../../../DesignSystem/shared/styles.dart';
import '../../../DesignSystem/shared/spacing.dart';
import '../../../DesignSystem/Components/FilterChip/filter_chip.dart';
import '../../../DesignSystem/Components/FilterChip/filter_chip_view_model.dart';
import '../../../DesignSystem/Components/EmptyState/empty_state.dart';
import '../../../DesignSystem/Components/EmptyState/empty_state_view_model.dart';
import '../../../DesignSystem/Components/Tag/tag.dart';
import '../../../DesignSystem/Components/Tag/tag_view_model.dart';
import '../../../DesignSystem/Components/SimpleAppBar/simple_app_bar.dart';
import '../../../DesignSystem/Components/DSTabBar/ds_tab_bar.dart';
import '../../../DesignSystem/Components/Buttons/ActionButton/action_button.dart';
import 'jobs_view_model.dart';

class JobsView extends StatelessWidget {
  final JobsViewModel viewModel;
  final bool showBottomNav;

  const JobsView({super.key, required this.viewModel, this.showBottomNav = true});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<JobsViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: gray_200,
            appBar: SimpleAppBar.instantiate(viewModel: vm.appBarViewModel),
            body: vm.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      DSTabBar.instantiate(viewModel: vm.tabBarViewModel),
                      if (vm.currentTab == 0) _buildFilters(vm),
                      Expanded(
                        child: vm.currentTab == 0
                            ? _buildJobsList(vm)
                            : _buildSavedJobsList(vm),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }

  Widget _buildFilters(JobsViewModel vm) {
    return Container(
      color: white,
      padding: EdgeInsets.symmetric(horizontal: small, vertical: extraSmall),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: vm.filters.map((filter) {
            final isSelected = vm.selectedFilter == filter;
            return Padding(
              padding: EdgeInsets.only(right: doubleXS),
              child: StyledFilterChip.instantiate(
                viewModel: FilterChipViewModel(
                  label: filter,
                  isSelected: isSelected,
                  onSelected: (_) => vm.setFilter(filter),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildJobsList(JobsViewModel vm) {
    if (vm.jobs.isEmpty) {
      return _buildEmptyState('Nenhuma vaga encontrada', 'Tente alterar os filtros');
    }
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: doubleXS),
      itemCount: vm.jobs.length,
      itemBuilder: (context, index) {
        return _buildJobCard(vm.jobs[index], vm);
      },
    );
  }

  Widget _buildSavedJobsList(JobsViewModel vm) {
    if (vm.savedJobs.isEmpty) {
      return _buildEmptyState('Nenhuma vaga salva', 'Salve vagas para ver aqui');
    }
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: doubleXS),
      itemCount: vm.savedJobs.length,
      itemBuilder: (context, index) {
        return _buildJobCard(vm.savedJobs[index], vm);
      },
    );
  }

  Widget _buildEmptyState(String title, String subtitle) {
    return EmptyState.instantiate(
      viewModel: EmptyStateViewModel(
        icon: Icons.work_off_outlined,
        title: title,
        subtitle: subtitle,
      ),
    );
  }

  Widget _buildJobCard(JobModel job, JobsViewModel vm) {
    final isSaved = vm.isJobSaved(job.id);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: tripleXS),
      padding: EdgeInsets.all(small),
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: gray_200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.business, color: gray_600, size: 28),
              ),
              SizedBox(width: extraSmall),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.title, style: labelTextStyle.copyWith(color: blue_600, fontSize: 16),),
                    SizedBox(height: 2),
                    Text(
                      job.company, style: label2Regular.copyWith(color: primaryInk, fontSize: 14),
                    ),
                    SizedBox(height: 2),
                    Text(
                      job.location, style: label2Regular.copyWith(color: gray_600, fontSize: 13),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  isSaved ? Icons.bookmark : Icons.bookmark_outline, color: isSaved ? blue_500 : gray_600,
                ),
                onPressed: () => vm.toggleSaveJob(job.id),
              ),
            ],
          ),
          SizedBox(height: extraSmall),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Tag.instantiate(
                viewModel: TagViewModel(
                  text: vm.getTypeLabel(job.type),
                  color: vm.getTypeColor(job.type),
                ),
              ),
              Tag.instantiate(
                viewModel: TagViewModel(
                  text: job.salary,
                  color: green_confirmation,
                ),
              ),
              if (job.isEasyApply)
                Tag.instantiate(
                  viewModel: TagViewModel(
                    text: 'Candidatura simplificada',
                    color: mint_dark,
                  ),
                ),
            ],
          ),
          SizedBox(height: extraSmall),
          Row(
            children: [
              const Icon(Icons.schedule, size: 14, color: gray_500),
              SizedBox(width: tripleXS),
              Text(
                'Publicada há ${job.postedAgo}',
                style: label2Regular.copyWith(color: gray_500),
              ),
              SizedBox(width: small),
              const Icon(Icons.people_outline, size: 14, color: gray_500),
              SizedBox(width: tripleXS),
              Text(
                '${job.applicants} candidatos',
                style: label2Regular.copyWith(color: gray_500),
              ),
            ],
          ),
          SizedBox(height: extraSmall),
          ActionButton.instantiate(
            viewModel: vm.getApplyButtonViewModel(job.id),
          ),
        ],
      ),
    );
  }
}
