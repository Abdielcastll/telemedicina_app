import 'package:telemedicina_app/features/authentication/_export.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this.remoteDataSource});

  final AuthRemoteDataSource remoteDataSource;

  @override
  Future<User> login({required String username, required String password}) {
    return remoteDataSource.login(username: username, password: password);
  }
}
