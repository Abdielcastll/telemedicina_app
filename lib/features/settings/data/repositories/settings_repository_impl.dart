import 'package:telemedicina_app/features/settings/data/datasources/settings_data_source.dart';
import 'package:telemedicina_app/features/settings/domain/entities/setting_exception.dart';
import 'package:telemedicina_app/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl({required this.dataSource});

  final SettingsDataSource dataSource;

  @override
  Future<List<SettingException>> getTypeSettingExceptionByUserId(int userId) {
    return dataSource.getTypeSettingExceptionByUserId(userId);
  }
}
