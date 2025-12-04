import 'package:flutter/material.dart';
import '../../../resources/shared/app_coordinator.dart';
import '../../jobPrediction/job_prediction_service.dart';

class UserProfileModel {
  final String name;
  final String headline;
  final String location;
  final String avatar;
  final int connections;
  final String about;
  final List<ExperienceModel> experiences;
  final List<EducationModel> education;
  final List<String> skills;

  UserProfileModel({
    required this.name,
    required this.headline,
    required this.location,
    required this.avatar,
    required this.connections,
    required this.about,
    required this.experiences,
    required this.education,
    required this.skills,
  });
}

class ExperienceModel {
  final String title;
  final String company;
  final String duration;
  final String location;
  final String? description;

  ExperienceModel({
    required this.title,
    required this.company,
    required this.duration,
    required this.location,
    this.description,
  });
}

class EducationModel {
  final String institution;
  final String degree;
  final String period;

  EducationModel({
    required this.institution,
    required this.degree,
    required this.period,
  });
}

class ProfileViewModel extends ChangeNotifier {
  final AppCoordinator coordinator;
  final JobPredictionService _predictionService = JobPredictionService();

  UserProfileModel? _profile;
  bool _isLoading = false;
  bool _isEditing = false;
  
  // Salary prediction state
  String? _predictedSalary;
  bool _isPredicting = false;
  String? _predictionError;

  ProfileViewModel({required this.coordinator}) {
    _loadProfile();
  }

  UserProfileModel? get profile => _profile;
  bool get isLoading => _isLoading;
  bool get isEditing => _isEditing;
  String? get predictedSalary => _predictedSalary;
  bool get isPredicting => _isPredicting;
  String? get predictionError => _predictionError;

  void _loadProfile() {
    _isLoading = true;
    notifyListeners();

    _profile = UserProfileModel(
      name: 'Victor Hugo',
      headline: 'Desenvolvedor Mobile | Flutter | iOS | Android',
      location: 'São Paulo, Brasil',
      avatar: 'VH',
      connections: 487,
      about: 'Desenvolvedor apaixonado por criar aplicativos móveis incríveis. '
          'Especializado em Flutter e desenvolvimento nativo. '
          'Sempre buscando aprender novas tecnologias e compartilhar conhecimento com a comunidade.',
      experiences: [
        ExperienceModel(
          title: 'Desenvolvedor Mobile Senior',
          company: 'Tech Innovation',
          duration: 'jan 2022 - Presente · 2 anos',
          location: 'São Paulo, Brasil',
          description: 'Desenvolvimento de aplicativos Flutter multiplataforma. '
              'Liderança técnica de squad mobile.',
        ),
        ExperienceModel(
          title: 'Desenvolvedor Flutter',
          company: 'StartupXYZ',
          duration: 'mar 2020 - dez 2021 · 1 ano 10 meses',
          location: 'São Paulo, Brasil',
          description: 'Desenvolvimento e manutenção de apps Flutter.',
        ),
        ExperienceModel(
          title: 'Desenvolvedor Android',
          company: 'Mobile Solutions',
          duration: 'jan 2018 - fev 2020 · 2 anos 2 meses',
          location: 'São Paulo, Brasil',
        ),
      ],
      education: [
        EducationModel(
          institution: 'Universidade de São Paulo',
          degree: 'Bacharelado em Ciência da Computação',
          period: '2014 - 2018',
        ),
        EducationModel(
          institution: 'Alura',
          degree: 'Formação Flutter',
          period: '2020',
        ),
      ],
      skills: [
        'Flutter',
        'Dart',
        'iOS',
        'Android',
        'Swift',
        'Kotlin',
        'Firebase',
        'REST APIs',
        'Git',
        'Agile/Scrum',
      ],
    );

    _isLoading = false;
    notifyListeners();
  }

  void toggleEditing() {
    _isEditing = !_isEditing;
    notifyListeners();
  }

  void goBack() {
    coordinator.pop();
  }

  void goToSettings() {
    // Navigate to settings
  }

  void shareProfile() {
  }

  void onSearchTapped() {
  }

  void onConnectTapped() {
  }

  void onSendMessageTapped() {
  }

  void onAddSectionTapped() {
  }

  void onEditAboutTapped() {
  }

  void onAddExperienceTapped() {
  }

  void onEditExperienceTapped() {
  }

  void onAddEducationTapped() {
  }

  void onAddSkillsTapped() {
  }

  Future<void> calculateSalaryPrediction() async {
    _isPredicting = true;
    _predictionError = null;
    notifyListeners();

    try {
      // Use profile skills to determine prediction inputs
      final skills = _profile?.skills ?? [];
      final hasPython = skills.contains('Python') || skills.contains('Dart');
      final hasAws = skills.contains('Firebase') || skills.contains('AWS');
      
      final response = await _predictionService.predictSalary(
        rating: 4.0,
        age: 5,
        sameState: 1,
        pythonYn: hasPython ? 1 : 0,
        rYn: 0,
        spark: 0,
        aws: hasAws ? 1 : 0,
        excel: 0,
        jobSimp: 'data scientist',
        seniority: 'senior',
        descLen: 500,
        numComp: 3,
      );

      _predictedSalary = '\$${(response["predicted_salary"] as num).toStringAsFixed(1)}K';
    } catch (e) {
      _predictionError = 'Não foi possível calcular';
    } finally {
      _isPredicting = false;
      notifyListeners();
    }
  }
}
