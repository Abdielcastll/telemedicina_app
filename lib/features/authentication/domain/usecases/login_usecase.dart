import 'package:telemedicina_app/features/authentication/_export.dart';

class LoginUseCase {
  LoginUseCase(this.repository);

  final AuthRepository repository;

  Future<User> call({required String username, required String password}) {
    return repository.login(username: username, password: password);
  }
}
