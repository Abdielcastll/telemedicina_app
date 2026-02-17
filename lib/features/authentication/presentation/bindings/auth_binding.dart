import 'package:get/get.dart';
import 'package:telemedicina_app/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:telemedicina_app/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:telemedicina_app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:telemedicina_app/features/authentication/domain/usecases/login_usecase.dart';
import 'package:telemedicina_app/features/authentication/presentation/getx/login_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<AuthRemoteDataSource>(() => FakeAuthRemoteDataSource())
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
