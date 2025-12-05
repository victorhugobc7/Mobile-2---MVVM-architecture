
class LoginService {
  Future <Map<String, dynamic>> fetchLogin({required String user, required String password}) async {
    await Future.delayed(const Duration(seconds: 3));

    return {"name" : "Marcio Ferreira", "address" : "Rua Teotonio Segurado, 1234 - Plano diretor Sul" };
  }
}