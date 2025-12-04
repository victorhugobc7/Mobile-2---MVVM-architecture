import 'package:flutter/material.dart';
import '../../../resources/shared/app_coordinator.dart';

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

  List<JobModel> _jobs = [];
  List<JobModel> _savedJobs = [];
  bool _isLoading = false;
  String _selectedFilter = 'Todas';
  int _currentTab = 0;

  final List<String> filters = ['Todas', 'Remoto', 'Híbrido', 'Presencial'];

  JobsViewModel({required this.coordinator}) {
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

  void _loadJobs() {
    _isLoading = true;
    notifyListeners();

    _jobs = [
      JobModel(
        id: '1',
        title: 'Desenvolvedor Flutter Senior',
        company: 'iFood',
        location: 'São Paulo, SP',
        salary: 'R\$ 15.000 - R\$ 22.000',
        postedAgo: '2 horas',
        type: 'hybrid',
        isEasyApply: true,
        applicants: 45,
      ),
      JobModel(
        id: '2',
        title: 'Mobile Developer',
        company: 'Nubank',
        location: 'Brasil',
        salary: 'R\$ 18.000 - R\$ 25.000',
        postedAgo: '5 horas',
        type: 'remote',
        isEasyApply: true,
        applicants: 120,
      ),
      JobModel(
        id: '3',
        title: 'Desenvolvedor Android Pleno',
        company: 'Mercado Livre',
        location: 'Osasco, SP',
        salary: 'R\$ 12.000 - R\$ 16.000',
        postedAgo: '1 dia',
        type: 'presential',
        applicants: 78,
      ),
      JobModel(
        id: '4',
        title: 'Flutter Engineer',
        company: 'PicPay',
        location: 'Brasil',
        salary: 'R\$ 14.000 - R\$ 20.000',
        postedAgo: '1 dia',
        type: 'remote',
        isEasyApply: true,
        applicants: 95,
      ),
      JobModel(
        id: '5',
        title: 'Desenvolvedor Mobile iOS/Android',
        company: 'Itaú',
        location: 'São Paulo, SP',
        salary: 'R\$ 16.000 - R\$ 23.000',
        postedAgo: '2 dias',
        type: 'hybrid',
        applicants: 156,
      ),
      JobModel(
        id: '6',
        title: 'Tech Lead Mobile',
        company: 'Globo',
        location: 'Rio de Janeiro, RJ',
        salary: 'R\$ 22.000 - R\$ 30.000',
        postedAgo: '3 dias',
        type: 'hybrid',
        isEasyApply: true,
        applicants: 67,
      ),
      JobModel(
        id: '7',
        title: 'Desenvolvedor Flutter Junior',
        company: 'Startup XYZ',
        location: 'Brasil',
        salary: 'R\$ 5.000 - R\$ 8.000',
        postedAgo: '4 dias',
        type: 'remote',
        isEasyApply: true,
        applicants: 234,
      ),
    ];

    _savedJobs = [_jobs[1], _jobs[3]];

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
