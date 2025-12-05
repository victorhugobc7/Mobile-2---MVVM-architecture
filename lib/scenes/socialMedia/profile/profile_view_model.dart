import 'package:flutter/material.dart';
import '../../../resources/shared/app_coordinator.dart';
import '../../jobPrediction/job_prediction_service.dart';
import 'profile_service.dart';

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
  final ProfileService service;
  final JobPredictionService _predictionService = JobPredictionService();

  UserProfileModel? _profile;
  bool _isLoading = false;
  bool _isEditing = false;
  
  // Salary prediction state
  String? _predictedSalary;
  bool _isPredicting = false;
  String? _predictionError;

  ProfileViewModel({required this.coordinator, required this.service}) {
    _loadProfile();
  }

  UserProfileModel? get profile => _profile;
  bool get isLoading => _isLoading;
  bool get isEditing => _isEditing;
  String? get predictedSalary => _predictedSalary;
  bool get isPredicting => _isPredicting;
  String? get predictionError => _predictionError;

  Future<void> _loadProfile() async {
    _isLoading = true;
    notifyListeners();

    try {
      _profile = await service.fetchProfile();
    } catch (e) {
      // Handle error
    }

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
