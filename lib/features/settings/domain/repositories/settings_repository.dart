import 'package:telemedicina_app/features/settings/domain/entities/setting_exception.dart';

abstract class SettingsRepository {
  Future<List<SettingException>> getTypeSettingExceptionByUserId(int userId);
}
