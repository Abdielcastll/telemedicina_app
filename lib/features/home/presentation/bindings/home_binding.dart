import 'package:get/get.dart';
import 'package:telemedicina_app/features/home/presentation/getx/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
