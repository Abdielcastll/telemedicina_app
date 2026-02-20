import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:telemedicina_app/core/services/auth_session_service.dart';
import 'package:telemedicina_app/features/authentication/_export.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<AuthSessionService>()) {
      Get.lazyPut<AuthSessionService>(() => AuthSessionService(), fenix: true);
    }

    if (!Get.isRegistered<http.Client>()) {
      Get.lazyPut<http.Client>(() => http.Client(), fenix: true);
    }

    Get
      ..lazyPut<AuthRemoteDataSource>(
        () => HttpAuthRemoteDataSource(
          client: Get.find<http.Client>(),
          sessionService: Get.find<AuthSessionService>(),
        ),
      )
      ..lazyPut<AuthRepository>(
        () => AuthRepositoryImpl(
          remoteDataSource: Get.find<AuthRemoteDataSource>(),
        ),
      )
      ..lazyPut<LoginUseCase>(() => LoginUseCase(Get.find<AuthRepository>()))
      ..lazyPut<LoginController>(
        () => LoginController(loginUseCase: Get.find<LoginUseCase>()),
      );
  }
}
