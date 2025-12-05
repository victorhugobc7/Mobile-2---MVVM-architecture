import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../DesignSystem/shared/colors.dart';
import '../../../DesignSystem/shared/styles.dart';
import '../../../DesignSystem/shared/spacing.dart';
import '../../../DesignSystem/Components/Avatar/avatar.dart';
import '../../../DesignSystem/Components/Avatar/avatar_view_model.dart';
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
    return Container(
      color: white,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(height: 60, color: blue_600),
              Positioned(
                left: small,
                bottom: -40,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: white, width: 4),
                  ),
                  child: Avatar.instantiate(
                    viewModel: AvatarViewModel(
                      initials: profile.avatar,
                      size: 100,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: small,
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
          SizedBox(height: 50),
          Padding(
            padding: EdgeInsets.all(small),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.name,
                  style: title4.copyWith(color: primaryInk),
                ),
                SizedBox(height: tripleXS),
                Text(
                  profile.headline,
                  style: label2Regular.copyWith(color: secondaryInk),
                ),
                SizedBox(height: doubleXS),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: gray_600),
                    SizedBox(width: tripleXS),
                    Text(
                      profile.location,
                      style: label2Regular.copyWith(color: gray_600),
                    ),
                  ],
                ),
                SizedBox(height: doubleXS),
                Text(
                  '${profile.connections}+ conexões',
                  style: labelTextStyle.copyWith(color: blue_500),
                ),
                SizedBox(height: small),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: vm.onConnectTapped,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: blue_500,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(vertical: extraSmall),
                        ),
                        child: Text(
                          'Aberto a',
                          style: label2Regular.copyWith(color: white),
                        ),
                      ),
                    ),
                    SizedBox(width: doubleXS),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: vm.onAddSectionTapped,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: blue_500),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(vertical: extraSmall),
                        ),
                        child: Text(
                          'Adicionar seção',
                          style: label2Regular.copyWith(color: blue_500),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sobre',
                style: labelTextStyle.copyWith(color: primaryInk, fontSize: 18),
              ),
              if (vm.isEditing)
                IconButton(
                  icon: const Icon(Icons.edit, size: 20, color: gray_600),
                  onPressed: vm.onEditAboutTapped,
                ),
            ],
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Experiência',
                style: labelTextStyle.copyWith(color: primaryInk, fontSize: 18),
              ),
              if (vm.isEditing)
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add, size: 20, color: gray_600),
                      onPressed: vm.onAddExperienceTapped,
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, size: 20, color: gray_600),
                      onPressed: vm.onEditExperienceTapped,
                    ),
                  ],
                ),
            ],
          ),
          SizedBox(height: extraSmall),
          ...profile.experiences.map((exp) => _buildExperienceItem(exp)),
        ],
      ),
    );
  }

  Widget _buildExperienceItem(ExperienceModel experience) {
    return Padding(
      padding: EdgeInsets.only(bottom: small),
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
          SizedBox(width: extraSmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  experience.title,
                  style: labelTextStyle.copyWith(color: primaryInk),
                ),
                Text(
                  experience.company,
                  style: label2Regular.copyWith(color: secondaryInk),
                ),
                Text(
                  experience.duration,
                  style: label2Regular.copyWith(color: gray_600),
                ),
                Text(
                  experience.location,
                  style: label2Regular.copyWith(color: gray_600),
                ),
                if (experience.description != null) ...[
                  SizedBox(height: doubleXS),
                  Text(
                    experience.description!,
                    style: label2Regular.copyWith(color: secondaryInk, fontSize: 13),
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
      margin: EdgeInsets.only(top: doubleXS),
      padding: EdgeInsets.all(small),
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Formação acadêmica',
                style: labelTextStyle.copyWith(color: primaryInk, fontSize: 18),
              ),
              if (vm.isEditing)
                IconButton(
                  icon: const Icon(Icons.add, size: 20, color: gray_600),
                  onPressed: vm.onAddEducationTapped,
                ),
            ],
          ),
          SizedBox(height: extraSmall),
          ...profile.education.map((edu) => _buildEducationItem(edu)),
        ],
      ),
    );
  }

  Widget _buildEducationItem(EducationModel education) {
    return Padding(
      padding: EdgeInsets.only(bottom: small),
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
          SizedBox(width: extraSmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  education.institution,
                  style: labelTextStyle.copyWith(color: primaryInk),
                ),
                Text(
                  education.degree,
                  style: label2Regular.copyWith(color: secondaryInk),
                ),
                Text(
                  education.period,
                  style: label2Regular.copyWith(color: gray_600),
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
      margin: EdgeInsets.only(top: doubleXS),
      padding: EdgeInsets.all(small),
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Competências',
                style: labelTextStyle.copyWith(color: primaryInk, fontSize: 18),
              ),
              if (vm.isEditing)
                IconButton(
                  icon: const Icon(Icons.add, size: 20, color: gray_600),
                  onPressed: vm.onAddSkillsTapped,
                ),
            ],
          ),
          SizedBox(height: extraSmall),
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
      padding: EdgeInsets.symmetric(horizontal: extraSmall, vertical: tripleXS + 2),
      decoration: BoxDecoration(
        color: blue_100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        skill,
        style: label2Regular.copyWith(color: blue_600),
      ),
    );
  }
}
