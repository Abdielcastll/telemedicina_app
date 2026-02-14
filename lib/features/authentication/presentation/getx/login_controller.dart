import 'package:get/get.dart';
import 'package:telemedicina_app/core/routes/app_routes.dart';
import 'package:telemedicina_app/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:telemedicina_app/features/authentication/domain/usecases/login_usecase.dart';

class LoginController extends GetxController {
  LoginController({required this.loginUseCase});

  final LoginUseCase loginUseCase;

  final email = ''.obs;
  final password = ''.obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  Future<void> login() async {
    if (isLoading.value) return;
    errorMessage.value = '';
    isLoading.value = true;
    try {
      await loginUseCase(email: email.value.trim(), password: password.value);
      Get.snackbar('Inicio de sesion', 'Bienvenido');
      Get.offAllNamed(Routes.home);
    } on AuthException catch (e) {
      errorMessage.value = e.message;
    } catch (_) {
      errorMessage.value = 'Ocurrio un error inesperado.';
    } finally {
      isLoading.value = false;
    }
  }
}
