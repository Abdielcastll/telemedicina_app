import '../models/user_model.dart';

class AuthException implements Exception {
  AuthException(this.message);

  final String message;
}

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});
}

class FakeAuthRemoteDataSource implements AuthRemoteDataSource {
  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (email == 'demo@telemedicina.com' && password == '123456') {
      return const UserModel(
        id: '1',
        name: 'Demo',
        email: 'demo@telemedicina.com',
      );
    }
    throw AuthException('Credenciales invalidas.');
  }
}
