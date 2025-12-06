import 'jobs_view_model.dart';

class JobsService {
  Future<List<JobModel>> fetchJobs() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
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
        title: 'Desenvolvedor Mobile Pleno',
        company: 'Mercado Livre',
        location: 'São Paulo, SP',
        salary: 'R\$ 12.000 - R\$ 18.000',
        postedAgo: '1 dia',
        type: 'hybrid',
        isEasyApply: false,
        applicants: 89,
      ),
      JobModel(
        id: '4',
        title: 'Flutter Developer',
        company: 'PicPay',
        location: 'São Paulo, SP',
        salary: 'R\$ 14.000 - R\$ 20.000',
        postedAgo: '2 dias',
        type: 'presential',
        isEasyApply: true,
        applicants: 56,
      ),
      JobModel(
        id: '5',
        title: 'Mobile Engineer',
        company: 'Itaú',
        location: 'São Paulo, SP',
        salary: 'R\$ 16.000 - R\$ 24.000',
        postedAgo: '3 dias',
        type: 'hybrid',
        isEasyApply: false,
        applicants: 203,
      ),
      JobModel(
        id: '5',
        title: 'Mobile Engineer',
        company: 'Itaú',
        location: 'São Paulo, SP',
        salary: 'R\$ 16.000 - R\$ 24.000',
        postedAgo: '3 dias',
        type: 'hybrid',
        isEasyApply: false,
        applicants: 203,
      ),
    ];
  }

  Future<List<JobModel>> fetchSavedJobs() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [];
  }

  Future<bool> saveJob(String jobId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Future<bool> unsaveJob(String jobId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Future<bool> applyToJob(String jobId, {String? coverLetter}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }

  Future<List<JobModel>> searchJobs(String query) async {
    final jobs = await fetchJobs();
    return jobs.where((j) =>
      j.title.toLowerCase().contains(query.toLowerCase()) ||
      j.company.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  Future<List<JobModel>> filterByType(String type) async {
    final jobs = await fetchJobs();
    if (type == 'all') return jobs;
    return jobs.where((j) => j.type == type).toList();
  }
}
