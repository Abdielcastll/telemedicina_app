import 'package:get/get.dart';
import 'package:telemedicina_app/features/home/data/datasources/doctor_availability_data_source.dart';
import 'package:telemedicina_app/features/home/data/repositories/doctor_availability_repository_impl.dart';
import 'package:telemedicina_app/features/home/domain/repositories/doctor_availability_repository.dart';
import 'package:telemedicina_app/features/home/domain/usecases/check_doctor_availability_usecase.dart';
import 'package:telemedicina_app/features/home/presentation/getx/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<DoctorAvailabilityDataSource>(
        () => FakeDoctorAvailabilityDataSource(),
      )
      ..lazyPut<DoctorAvailabilityRepository>(
        () => DoctorAvailabilityRepositoryImpl(
          dataSource: Get.find<DoctorAvailabilityDataSource>(),
        ),
      )
      ..lazyPut<CheckDoctorAvailabilityUseCase>(
        () => CheckDoctorAvailabilityUseCase(
          Get.find<DoctorAvailabilityRepository>(),
        ),
      )
      ..lazyPut<HomeController>(
        () => HomeController(
          checkDoctorAvailabilityUseCase:
              Get.find<CheckDoctorAvailabilityUseCase>(),
        ),
      );
  }
}
