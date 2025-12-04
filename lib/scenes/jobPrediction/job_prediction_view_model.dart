import 'package:flutter/material.dart';
import '../../resources/shared/app_coordinator.dart';
import 'job_prediction_service.dart';

class JobPredictionViewModel extends ChangeNotifier {
  final JobPredictionService service;
  final AppCoordinator coordinator;

  final TextEditingController ratingController = TextEditingController();
  final TextEditingController companyAgeController = TextEditingController();
  final TextEditingController numCompController = TextEditingController();

  bool _sameState = false;
  bool _pythonYn = false;
  bool _rYn = false;
  bool _spark = false;
  bool _aws = false;
  bool _excel = false;

  String? _selectedJobType;
  String? _selectedSeniority;

  String? _predictedSalary;
  String? _currency;
  String? _unit;
  bool _isLoading = false;
  String? _error;

  final List<String> jobTypes = ['data scientist', 'data engineer', 'analyst', 'machine learning', 'manager', 'director'];
  final List<String> seniorityLevels = ['na', 'junior', 'senior', 'lead', 'principal'];

  JobPredictionViewModel({required this.service, required this.coordinator});

  bool get sameState => _sameState;
  bool get pythonYn => _pythonYn;
  bool get rYn => _rYn;
  bool get spark => _spark;
  bool get aws => _aws;
  bool get excel => _excel;
  String? get selectedJobType => _selectedJobType;
  String? get selectedSeniority => _selectedSeniority;
  String? get predictedSalary => _predictedSalary;
  String? get currency => _currency;
  String? get unit => _unit;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void setSameState(bool value) {
    _sameState = value;
    notifyListeners();
  }

  void setPythonYn(bool value) {
    _pythonYn = value;
    notifyListeners();
  }

  void setRYn(bool value) {
    _rYn = value;
    notifyListeners();
  }

  void setSpark(bool value) {
    _spark = value;
    notifyListeners();
  }

  void setAws(bool value) {
    _aws = value;
    notifyListeners();
  }

  void setExcel(bool value) {
    _excel = value;
    notifyListeners();
  }

  void setSelectedJobType(String? value) {
    _selectedJobType = value;
    notifyListeners();
  }

  void setSelectedSeniority(String? value) {
    _selectedSeniority = value;
    notifyListeners();
  }

  Future<void> predictSalary() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await service.predictSalary(
        rating: double.tryParse(ratingController.text) ?? 3.0,
        age: int.tryParse(companyAgeController.text) ?? 10,
        sameState: _sameState ? 1 : 0,
        pythonYn: _pythonYn ? 1 : 0,
        rYn: _rYn ? 1 : 0,
        spark: _spark ? 1 : 0,
        aws: _aws ? 1 : 0,
        excel: _excel ? 1 : 0,
        jobSimp: _selectedJobType ?? 'data scientist',
        seniority: _selectedSeniority ?? 'na',
        descLen: 500,
        numComp: int.tryParse(numCompController.text) ?? 3,
      );

      _predictedSalary = (response["predicted_salary"] as num).toStringAsFixed(1);
      _currency = response["currency"] as String? ?? "USD";
      _unit = response["unit"] as String? ?? "milhares (K)";
    } catch (e) {
      _error = "Falha ao prever salário. Por favor, tente novamente.";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearForm() {
    ratingController.clear();
    companyAgeController.clear();
    numCompController.clear();
    _sameState = false;
    _pythonYn = false;
    _rYn = false;
    _spark = false;
    _aws = false;
    _excel = false;
    _selectedJobType = null;
    _selectedSeniority = null;
    _predictedSalary = null;
    _currency = null;
    _unit = null;
    _error = null;
    notifyListeners();
  }

  void goBack() {
    coordinator.pop();
  }

  @override
  void dispose() {
    ratingController.dispose();
    companyAgeController.dispose();
    numCompController.dispose();
    super.dispose();
  }
}
