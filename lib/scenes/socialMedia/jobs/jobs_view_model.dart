import 'package:flutter/material.dart';
import '../../../resources/shared/app_coordinator.dart';
import 'jobs_service.dart';

class JobModel {
  final String id;
  final String title;
  final String company;
  final String location;
  final String salary;
  final String postedAgo;
  final String type; // 'remote', 'hybrid', 'presential'
  final bool isSaved;
  final bool isEasyApply;
  final int applicants;

  JobModel({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.postedAgo,
    required this.type,
    this.isSaved = false,
    this.isEasyApply = false,
    required this.applicants,
  });
}

class JobsViewModel extends ChangeNotifier {
  final AppCoordinator coordinator;
  final JobsService service;

  List<JobModel> _jobs = [];
  List<JobModel> _savedJobs = [];
  bool _isLoading = false;
  String _selectedFilter = 'Todas';
  int _currentTab = 0;

  final List<String> filters = ['Todas', 'Remoto', 'Híbrido', 'Presencial'];

  JobsViewModel({required this.coordinator, required this.service}) {
    _loadJobs();
  }

  List<JobModel> get jobs {
    if (_selectedFilter == 'Todas') return _jobs;
    String filterType = _selectedFilter.toLowerCase();
    if (filterType == 'remoto') filterType = 'remote';
    if (filterType == 'híbrido') filterType = 'hybrid';
    if (filterType == 'presencial') filterType = 'presential';
    return _jobs.where((j) => j.type == filterType).toList();
  }

  List<JobModel> get savedJobs => _savedJobs;
  bool get isLoading => _isLoading;
  String get selectedFilter => _selectedFilter;
  int get currentTab => _currentTab;

  Future<void> _loadJobs() async {
    _isLoading = true;
    notifyListeners();

    try {
      _jobs = await service.fetchJobs();
      _savedJobs = await service.fetchSavedJobs();
    } catch (e) {

    }

    _isLoading = false;
    notifyListeners();
  }

  void setFilter(String filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

  void setTab(int index) {
    _currentTab = index;
    notifyListeners();
  }

  void toggleSaveJob(String id) {
    final jobIndex = _jobs.indexWhere((j) => j.id == id);
    if (jobIndex != -1) {
      final job = _jobs[jobIndex];
      if (_savedJobs.any((j) => j.id == id)) {
        _savedJobs.removeWhere((j) => j.id == id);
      } else {
        _savedJobs.add(job);
      }
      notifyListeners();
    }
  }

  bool isJobSaved(String id) {
    return _savedJobs.any((j) => j.id == id);
  }

  void applyToJob(String id) {
  }

  void goBack() {
    coordinator.pop();
  }

  void onSettingsTapped() {
  }
}
