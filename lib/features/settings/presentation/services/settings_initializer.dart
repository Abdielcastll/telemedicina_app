import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:telemedicina_app/core/services/auth_session_service.dart';
import 'package:telemedicina_app/features/settings/_export.dart';

Future<void> initializeSettingsFeature() async {
  if (!Get.isRegistered<AuthSessionService>()) {
    Get.put<AuthSessionService>(AuthSessionService(), permanent: true);
  }

  if (!Get.isRegistered<http.Client>()) {
    Get.put<http.Client>(http.Client(), permanent: true);
  }

  if (!Get.isRegistered<SettingsDataSource>()) {
    Get.put<SettingsDataSource>(
      HttpSettingsDataSource(
        client: Get.find<http.Client>(),
        sessionService: Get.find<AuthSessionService>(),
      ),
      permanent: true,
    );
  }

  if (!Get.isRegistered<SettingsRepository>()) {
    Get.put<SettingsRepository>(
      SettingsRepositoryImpl(dataSource: Get.find<SettingsDataSource>()),
      permanent: true,
    );
  }

  if (!Get.isRegistered<GetTypeSettingExceptionUseCase>()) {
    Get.put<GetTypeSettingExceptionUseCase>(
      GetTypeSettingExceptionUseCase(Get.find<SettingsRepository>()),
      permanent: true,
    );
  }

  if (!Get.isRegistered<SettingsService>()) {
    Get.put<SettingsService>(
      SettingsService(
        getTypeSettingExceptionUseCase:
            Get.find<GetTypeSettingExceptionUseCase>(),
      ),
      permanent: true,
    );
  }
}
