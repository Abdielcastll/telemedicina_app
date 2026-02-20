import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:telemedicina_app/core/services/auth_session_service.dart';
import 'package:telemedicina_app/features/symptoms/_export.dart';

class SymptomsBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<AuthSessionService>()) {
      Get.lazyPut<AuthSessionService>(() => AuthSessionService(), fenix: true);
    }

    if (!Get.isRegistered<http.Client>()) {
      Get.lazyPut<http.Client>(() => http.Client(), fenix: true);
    }

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
      ..lazyPut<ReasonDataSource>(
        () => HttpReasonDataSource(
          client: Get.find<http.Client>(),
          sessionService: Get.find<AuthSessionService>(),
        ),
      )
      ..lazyPut<ReasonRepository>(
        () => ReasonRepositoryImpl(dataSource: Get.find<ReasonDataSource>()),
      )
      ..lazyPut<GetReasonsUseCase>(
        () => GetReasonsUseCase(Get.find<ReasonRepository>()),
      )
      ..lazyPut<SaveSymptomsUseCase>(
        () => SaveSymptomsUseCase(Get.find<ReasonRepository>()),
      )
      ..lazyPut<SymptomsController>(
        () => SymptomsController(
          checkDoctorAvailabilityUseCase:
              Get.find<CheckDoctorAvailabilityUseCase>(),
          getReasonsUseCase: Get.find<GetReasonsUseCase>(),
          saveSymptomsUseCase: Get.find<SaveSymptomsUseCase>(),
        ),
      );
  }
}
