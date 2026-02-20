import 'package:telemedicina_app/features/settings/domain/entities/setting_exception.dart';
import 'package:telemedicina_app/features/settings/domain/repositories/settings_repository.dart';

class GetTypeSettingExceptionUseCase {
  GetTypeSettingExceptionUseCase(this.repository);

  final SettingsRepository repository;

  Future<List<SettingException>> call(int userId) {
    return repository.getTypeSettingExceptionByUserId(userId);
  }
}
