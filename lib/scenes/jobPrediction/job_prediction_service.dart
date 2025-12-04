import 'dart:convert';
import 'package:http/http.dart' as http;

class JobPredictionService {
  static const String _baseUrl = 'https://predictapi-production-e06c.up.railway.app';

  Future<Map<String, dynamic>> predictSalary({
    required double rating,
    required int age,
    int sameState = 0,
    int pythonYn = 0,
    int rYn = 0,
    int spark = 0,
    int aws = 0,
    int excel = 0,
    String jobSimp = 'data scientist',
    String seniority = 'na',
    int descLen = 500,
    int numComp = 0,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/predict'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'rating': rating,
        'age': age,
        'same_state': sameState,
        'python_yn': pythonYn,
        'R_yn': rYn,
        'spark': spark,
        'aws': aws,
        'excel': excel,
        'job_simp': jobSimp,
        'seniority': seniority,
        'desc_len': descLen,
        'num_comp': numComp,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to predict salary: ${response.statusCode}');
    }
  }
}
