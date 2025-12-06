import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../DesignSystem/shared/colors.dart';
import '../../../DesignSystem/shared/styles.dart';
import '../../../DesignSystem/shared/spacing.dart';
import '../../../DesignSystem/Components/SkillChip/skill_chip.dart';
import '../../../DesignSystem/Components/SkillChip/skill_chip_view_model.dart';
import '../../../DesignSystem/Components/ExperienceItem/experience_item.dart';
import '../../../DesignSystem/Components/ExperienceItem/experience_item_view_model.dart';
import '../../../DesignSystem/Components/EducationItem/education_item.dart';
import '../../../DesignSystem/Components/EducationItem/education_item_view_model.dart';
import '../../../DesignSystem/Components/ProfileHeader/profile_header.dart';
import '../../../DesignSystem/Components/ProfileHeader/profile_header_view_model.dart';
import '../../../DesignSystem/Components/ProfileSectionHeader/profile_section_header.dart';
import '../../../DesignSystem/Components/ProfileSectionHeader/profile_section_header_view_model.dart';
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
                            SizedBox(height: medium),
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
          onPressed: vm.onSearchTapped,
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
    return ProfileHeader.instantiate(
      viewModel: ProfileHeaderViewModel(
        name: profile.name,
        headline: profile.headline,
        location: profile.location,
        avatar: profile.avatar,
        connections: profile.connections,
        isEditing: vm.isEditing,
        onSharePressed: vm.shareProfile,
        onEditToggle: vm.toggleEditing,
        onConnectPressed: vm.onConnectTapped,
        onAddSectionPressed: vm.onAddSectionTapped,
      ),
    );
  }

  Widget _buildSalaryPredictionSection(ProfileViewModel vm) {
    return Container(
      margin: EdgeInsets.only(top: doubleXS),
      padding: EdgeInsets.all(small),
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.trending_up, color: green_confirmation, size: 24),
                  SizedBox(width: doubleXS),
                  Text(
                    'Previsão Salarial',
                    style: labelTextStyle.copyWith(color: primaryInk, fontSize: 18),
                  ),
                ],
              ),
              if (vm.predictedSalary == null && !vm.isPredicting)
                TextButton.icon(
                  onPressed: vm.calculateSalaryPrediction,
                  icon: const Icon(Icons.calculate, size: 18),
                  label: Text('Calcular', style: label2Regular.copyWith(color: blue_500)),
                  style: TextButton.styleFrom(foregroundColor: blue_500),
                ),
            ],
          ),
          SizedBox(height: extraSmall),
          if (vm.isPredicting)
            Center(
              child: Padding(
                padding: EdgeInsets.all(small),
                child: const CircularProgressIndicator(),
              ),
            )
          else if (vm.predictionError != null)
            Container(
              padding: EdgeInsets.all(extraSmall),
              decoration: BoxDecoration(
                color: red_error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: red_error, size: 20),
                  SizedBox(width: doubleXS),
                  Text(
                    vm.predictionError!,
                    style: label2Regular.copyWith(color: red_error),
                  ),
                ],
              ),
            )
          else if (vm.predictedSalary != null)
            Container(
              padding: EdgeInsets.all(small),
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
                  Text(
                    'Salário estimado baseado nas suas habilidades',
                    style: label2Regular.copyWith(color: gray_600),
                  ),
                  SizedBox(height: doubleXS),
                  Text(
                    vm.predictedSalary!,
                    style: title3.copyWith(color: green_confirmation),
                  ),
                  SizedBox(height: tripleXS),
                  Text(
                    'por ano (USD)',
                    style: label2Regular.copyWith(color: gray_600),
                  ),
                ],
              ),
            )
          else
            Container(
              padding: EdgeInsets.all(small),
              decoration: BoxDecoration(
                color: gray_200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.lightbulb_outline, color: yellow_marigold, size: 20),
                  SizedBox(width: extraSmall),
                  Expanded(
                    child: Text(
                      'Clique em "Calcular" para ver uma estimativa salarial baseada nas suas habilidades e experiência.',
                      style: label2Regular.copyWith(color: gray_600, fontSize: 13),
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
      margin: EdgeInsets.only(top: doubleXS),
      padding: EdgeInsets.all(small),
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileSectionHeader.instantiate(
            viewModel: ProfileSectionHeaderViewModel(
              title: 'Sobre',
              showEditButton: vm.isEditing,
              onEditPressed: vm.onEditAboutTapped,
            ),
          ),
          SizedBox(height: extraSmall),
          Text(
            profile.about,
            style: label2Regular.copyWith(color: secondaryInk, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceSection(ProfileViewModel vm) {
    final profile = vm.profile!;
    return Container(
      margin: EdgeInsets.only(top: doubleXS),
      padding: EdgeInsets.all(small),
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileSectionHeader.instantiate(
            viewModel: ProfileSectionHeaderViewModel(
              title: 'Experiência',
              showEditButton: vm.isEditing,
              showAddButton: vm.isEditing,
              onAddPressed: vm.onAddExperienceTapped,
              onEditPressed: vm.onEditExperienceTapped,
            ),
          ),
          SizedBox(height: extraSmall),
          ...profile.experiences.map((exp) => ExperienceItem.instantiate(
            viewModel: ExperienceItemViewModel(
              title: exp.title,
              company: exp.company,
              duration: exp.duration,
              location: exp.location,
              description: exp.description,
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildEducationSection(ProfileViewModel vm) {
    final profile = vm.profile!;
    return Container(
      margin: EdgeInsets.only(top: doubleXS),
      padding: EdgeInsets.all(small),
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileSectionHeader.instantiate(
            viewModel: ProfileSectionHeaderViewModel(
              title: 'Formação acadêmica',
              showAddButton: vm.isEditing,
              onAddPressed: vm.onAddEducationTapped,
            ),
          ),
          SizedBox(height: extraSmall),
          ...profile.education.map((edu) => EducationItem.instantiate(
            viewModel: EducationItemViewModel(
              institution: edu.institution,
              degree: edu.degree,
              period: edu.period,
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildSkillsSection(ProfileViewModel vm) {
    final profile = vm.profile!;
    return Container(
      margin: EdgeInsets.only(top: doubleXS),
      padding: EdgeInsets.all(small),
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileSectionHeader.instantiate(
            viewModel: ProfileSectionHeaderViewModel(
              title: 'Competências',
              showAddButton: vm.isEditing,
              onAddPressed: vm.onAddSkillsTapped,
            ),
          ),
          SizedBox(height: extraSmall),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: profile.skills.map((skill) => SkillChip.instantiate(
              viewModel: SkillChipViewModel(text: skill),
            )).toList(),
          ),
        ],
      ),
    );
  }
}
