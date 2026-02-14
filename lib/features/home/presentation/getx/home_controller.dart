import 'package:get/get.dart';
import 'package:telemedicina_app/core/routes/app_routes.dart';

class HomeController extends GetxController {
  void logout() {
    Get.offAllNamed(Routes.login);
  }
}
