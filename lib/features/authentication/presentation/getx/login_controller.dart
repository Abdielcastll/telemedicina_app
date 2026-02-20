import 'package:get/get.dart';
import 'package:telemedicina_app/core/_export.dart';
import 'package:telemedicina_app/features/authentication/_export.dart';
import 'package:telemedicina_app/features/settings/_export.dart';

class LoginController extends GetxController {
  LoginController({required this.loginUseCase});

  final LoginUseCase loginUseCase;

  final username = ''.obs;
  final password = ''.obs;
  final showPassword = false.obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  Future<void> login() async {
    if (isLoading.value) return;
    errorMessage.value = '';
    isLoading.value = true;
    try {
      final user = await loginUseCase(
        username: username.value.trim(),
        password: password.value,
      );

      await Get.find<SettingsService>().load(
        userId: user.userId,
        forceRefresh: true,
      );

      Get.snackbar('Inicio de sesion', 'Bienvenido');
      Get.offAllNamed(Routes.home);
    } on AppException catch (e) {
      errorMessage.value = e.message;
    } catch (e) {
      errorMessage.value = 'Ocurrio un error inesperado. $e';
    } finally {
      isLoading.value = false;
    }
  }
}
