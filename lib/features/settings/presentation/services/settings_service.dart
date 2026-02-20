import 'package:get/get.dart';
import 'package:telemedicina_app/features/settings/domain/entities/setting_exception.dart';
import 'package:telemedicina_app/features/settings/domain/usecases/get_type_setting_exception_usecase.dart';

class SettingsService extends GetxService {
  SettingsService({required this.getTypeSettingExceptionUseCase});

  final GetTypeSettingExceptionUseCase getTypeSettingExceptionUseCase;

  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final settingsByName = <String, SettingException>{}.obs;

  Future<void> load({required int userId, bool forceRefresh = false}) async {
    if (isLoading.value) return;
    if (settingsByName.isNotEmpty && !forceRefresh) return;

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final settings = await getTypeSettingExceptionUseCase(userId);
      settingsByName.assignAll({
        for (final setting in settings) setting.name: setting,
      });
    } catch (error) {
      errorMessage.value = error.toString();
    } finally {
      isLoading.value = false;
    }
  }

  SettingException? getByName(String name) => settingsByName[name];

  String? getString(String name) => getByName(name)?.value;

  bool? getBool(String name) {
    final value = getString(name)?.toLowerCase().trim();
    if (value == null || value.isEmpty) return null;

    if (value == 'true' || value == '1' || value == 'si' || value == 'sí') {
      return true;
    }

    if (value == 'false' || value == '0' || value == 'no') {
      return false;
    }

    return null;
  }

  int? getInt(String name) => int.tryParse(getString(name) ?? '');
}
