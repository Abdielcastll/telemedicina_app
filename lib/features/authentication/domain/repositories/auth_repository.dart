import 'package:telemedicina_app/features/authentication/_export.dart';

abstract class AuthRepository {
  Future<User> login({required String username, required String password});
}
