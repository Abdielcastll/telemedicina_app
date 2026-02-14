import 'package:get/get.dart';
import 'package:telemedicina_app/core/services/injector_container.dart';
import 'package:telemedicina_app/features/authentication/domain/usecases/login_usecase.dart';
import 'package:telemedicina_app/features/authentication/presentation/getx/login_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController(loginUseCase: sl<LoginUseCase>()));
  }
}
