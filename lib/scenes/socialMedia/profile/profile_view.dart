import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../resources/shared/colors.dart';
import 'profile_view_model.dart';

class ProfileView extends StatelessWidget {
  final ProfileViewModel viewModel;

  const ProfileView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<ProfileViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: gray_200,
            body: vm.isLoading
                ? const Center(child: CircularProgressIndicator())
                : CustomScrollView(
                    slivers: [
                      _buildAppBar(vm),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            _buildProfileHeader(vm),
                            _buildSalaryPredictionSection(vm),
                            _buildAboutSection(vm),
                            _buildExperienceSection(vm),
                            _buildEducationSection(vm),
                            _buildSkillsSection(vm),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }

  SliverAppBar _buildAppBar(ProfileViewModel vm) {
    return SliverAppBar(
      expandedHeight: 120,
      pinned: true,
      backgroundColor: blue_500,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: white),
        onPressed: vm.goBack,
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: white),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.settings, color: white),
          onPressed: vm.goToSettings,
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [blue_500, blue_700],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(ProfileViewModel vm) {
    final profile = vm.profile!;
    return Container(
      color: white,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(height: 60, color: blue_600),
              Positioned(
                left: 16,
                bottom: -40,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: white, width: 4),
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: navy_700,
                    child: Text(
                      profile.avatar,
                      style: const TextStyle(
                        color: white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 16,
                bottom: -20,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: vm.shareProfile,
                      icon: const Icon(Icons.share, color: blue_500),
                    ),
                    IconButton(
                      onPressed: vm.toggleEditing,
                      icon: Icon(
                        vm.isEditing ? Icons.close : Icons.edit,
                        color: blue_500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryInk,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  profile.headline,
                  style: const TextStyle(
                    fontSize: 14,
                    color: secondaryInk,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: gray_600),
                    const SizedBox(width: 4),
                    Text(
                      profile.location,
                      style: const TextStyle(
                        fontSize: 14,
                        color: gray_600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '${profile.connections}+ conexões',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: blue_500,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: blue_500,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          'Aberto a',
                          style: TextStyle(color: white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: blue_500),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          'Adicionar seção',
                          style: TextStyle(color: blue_500),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSalaryPredictionSection(ProfileViewModel vm) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.trending_up, color: green_confirmation, size: 24),
                  const SizedBox(width: 8),
                  const Text(
                    'Previsão Salarial',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryInk,
                    ),
                  ),
                ],
              ),
              if (vm.predictedSalary == null && !vm.isPredicting)
                TextButton.icon(
                  onPressed: vm.calculateSalaryPrediction,
                  icon: const Icon(Icons.calculate, size: 18),
                  label: const Text('Calcular'),
                  style: TextButton.styleFrom(foregroundColor: blue_500),
                ),
            ],
          ),
          const SizedBox(height: 12),
          if (vm.isPredicting)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            )
          else if (vm.predictionError != null)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: red_error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: red_error, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    vm.predictionError!,
                    style: const TextStyle(color: red_error),
                  ),
                ],
              ),
            )
          else if (vm.predictedSalary != null)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [blue_500.withOpacity(0.1), green_confirmation.withOpacity(0.1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: blue_500.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Salário estimado baseado nas suas habilidades',
                    style: TextStyle(fontSize: 12, color: gray_600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    vm.predictedSalary!,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: green_confirmation,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'por ano (USD)',
                    style: TextStyle(fontSize: 12, color: gray_600),
                  ),
                ],
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: gray_200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: yellow_marigold, size: 20),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Clique em "Calcular" para ver uma estimativa salarial baseada nas suas habilidades e experiência.',
                      style: TextStyle(fontSize: 13, color: gray_600),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAboutSection(ProfileViewModel vm) {
    final profile = vm.profile!;
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Sobre',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryInk,
                ),
              ),
              if (vm.isEditing)
                IconButton(
                  icon: const Icon(Icons.edit, size: 20, color: gray_600),
                  onPressed: () {},
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            profile.about,
            style: const TextStyle(
              fontSize: 14,
              color: secondaryInk,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceSection(ProfileViewModel vm) {
    final profile = vm.profile!;
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Experiência',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryInk,
                ),
              ),
              if (vm.isEditing)
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add, size: 20, color: gray_600),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, size: 20, color: gray_600),
                      onPressed: () {},
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 12),
          ...profile.experiences.map((exp) => _buildExperienceItem(exp)),
        ],
      ),
    );
  }

  Widget _buildExperienceItem(ExperienceModel experience) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: gray_200,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(Icons.business, color: gray_600),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  experience.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryInk,
                  ),
                ),
                Text(
                  experience.company,
                  style: const TextStyle(
                    fontSize: 14,
                    color: secondaryInk,
                  ),
                ),
                Text(
                  experience.duration,
                  style: const TextStyle(
                    fontSize: 12,
                    color: gray_600,
                  ),
                ),
                Text(
                  experience.location,
                  style: const TextStyle(
                    fontSize: 12,
                    color: gray_600,
                  ),
                ),
                if (experience.description != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    experience.description!,
                    style: const TextStyle(
                      fontSize: 13,
                      color: secondaryInk,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationSection(ProfileViewModel vm) {
    final profile = vm.profile!;
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Formação acadêmica',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryInk,
                ),
              ),
              if (vm.isEditing)
                IconButton(
                  icon: const Icon(Icons.add, size: 20, color: gray_600),
                  onPressed: () {},
                ),
            ],
          ),
          const SizedBox(height: 12),
          ...profile.education.map((edu) => _buildEducationItem(edu)),
        ],
      ),
    );
  }

  Widget _buildEducationItem(EducationModel education) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: gray_200,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(Icons.school, color: gray_600),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  education.institution,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryInk,
                  ),
                ),
                Text(
                  education.degree,
                  style: const TextStyle(
                    fontSize: 14,
                    color: secondaryInk,
                  ),
                ),
                Text(
                  education.period,
                  style: const TextStyle(
                    fontSize: 12,
                    color: gray_600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection(ProfileViewModel vm) {
    final profile = vm.profile!;
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Competências',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryInk,
                ),
              ),
              if (vm.isEditing)
                IconButton(
                  icon: const Icon(Icons.add, size: 20, color: gray_600),
                  onPressed: () {},
                ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: profile.skills.map((skill) => _buildSkillChip(skill)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: blue_100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        skill,
        style: const TextStyle(
          fontSize: 12,
          color: blue_600,
        ),
      ),
    );
  }
}
