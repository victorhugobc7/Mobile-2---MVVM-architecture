import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../DesignSystem/shared/colors.dart';
import '../../../DesignSystem/Components/FilterChip/filter_chip.dart';
import '../../../DesignSystem/Components/FilterChip/filter_chip_view_model.dart';
import 'jobs_view_model.dart';

class JobsView extends StatelessWidget {
  final JobsViewModel viewModel;

  const JobsView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<JobsViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: gray_200,
            appBar: AppBar(
              backgroundColor: white,
              elevation: 1,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: primaryInk),
                onPressed: vm.goBack,
              ),
              title: const Text(
                'Vagas',
                style: TextStyle(
                  color: primaryInk,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.tune, color: gray_600),
                  onPressed: vm.onSettingsTapped,
                ),
              ],
            ),
            body: vm.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      _buildTabBar(vm),
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

  Widget _buildTabBar(JobsViewModel vm) {
    return Container(
      color: white,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => vm.setTab(0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: vm.currentTab == 0 ? blue_500 : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  'Recomendadas',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: vm.currentTab == 0 ? blue_500 : gray_600,
                    fontWeight: vm.currentTab == 0 ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => vm.setTab(1),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: vm.currentTab == 1 ? blue_500 : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Salvas',
                      style: TextStyle(
                        color: vm.currentTab == 1 ? blue_500 : gray_600,
                        fontWeight: vm.currentTab == 1 ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    if (vm.savedJobs.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: vm.currentTab == 1 ? blue_500 : gray_400,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          vm.savedJobs.length.toString(),
                          style: const TextStyle(
                            color: white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters(JobsViewModel vm) {
    return Container(
      color: white,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: vm.filters.map((filter) {
            final isSelected = vm.selectedFilter == filter;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
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
      padding: const EdgeInsets.symmetric(vertical: 8),
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
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: vm.savedJobs.length,
      itemBuilder: (context, index) {
        return _buildJobCard(vm.savedJobs[index], vm);
      },
    );
  }

  Widget _buildEmptyState(String title, String subtitle) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.work_off_outlined, size: 80, color: gray_400),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: gray_600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 14, color: gray_500),
          ),
        ],
      ),
    );
  }

  Widget _buildJobCard(JobModel job, JobsViewModel vm) {
    final isSaved = vm.isJobSaved(job.id);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      padding: const EdgeInsets.all(16),
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
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: blue_600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      job.company,
                      style: const TextStyle(
                        fontSize: 14,
                        color: primaryInk,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      job.location,
                      style: const TextStyle(
                        fontSize: 13,
                        color: gray_600,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  isSaved ? Icons.bookmark : Icons.bookmark_outline,
                  color: isSaved ? blue_500 : gray_600,
                ),
                onPressed: () => vm.toggleSaveJob(job.id),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildTag(_getTypeLabel(job.type), _getTypeColor(job.type)),
              _buildTag(job.salary, green_confirmation),
              if (job.isEasyApply)
                _buildTag('Candidatura simplificada', mint_dark),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.schedule, size: 14, color: gray_500),
              const SizedBox(width: 4),
              Text(
                'Publicada há ${job.postedAgo}',
                style: const TextStyle(fontSize: 12, color: gray_500),
              ),
              const SizedBox(width: 16),
              Icon(Icons.people_outline, size: 14, color: gray_500),
              const SizedBox(width: 4),
              Text(
                '${job.applicants} candidatos',
                style: const TextStyle(fontSize: 12, color: gray_500),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => vm.applyToJob(job.id),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: blue_500),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Candidatar-se',
                    style: TextStyle(color: blue_500),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  String _getTypeLabel(String type) {
    switch (type) {
      case 'remote':
        return 'Remoto';
      case 'hybrid':
        return 'Híbrido';
      case 'presential':
        return 'Presencial';
      default:
        return type;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'remote':
        return blue_500;
      case 'hybrid':
        return yellow_marigold;
      case 'presential':
        return navy_700;
      default:
        return gray_600;
    }
  }
}
