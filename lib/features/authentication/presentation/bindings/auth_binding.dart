import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:telemedicina_app/core/services/auth_session_service.dart';
import 'package:telemedicina_app/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:telemedicina_app/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:telemedicina_app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:telemedicina_app/features/authentication/domain/usecases/login_usecase.dart';
import 'package:telemedicina_app/features/authentication/presentation/getx/login_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<AuthSessionService>(() => AuthSessionService(), fenix: true)
      ..lazyPut<http.Client>(() => http.Client(), fenix: true)
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
