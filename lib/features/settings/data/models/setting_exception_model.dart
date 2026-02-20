import 'package:telemedicina_app/features/settings/domain/entities/setting_exception.dart';

class SettingExceptionModel extends SettingException {
  const SettingExceptionModel({
    required super.settingExceptionId,
    required super.name,
    required super.displayName,
    required super.value,
  });

  factory SettingExceptionModel.fromJson(Map<String, dynamic> json) {
    return SettingExceptionModel(
      settingExceptionId: (json['SettingExceptionId'] as num?)?.toInt() ?? 0,
      name: (json['Name'] ?? '').toString(),
      displayName: (json['DisplayName'] ?? '').toString(),
      value: (json['Value'] ?? '').toString(),
    );
  }
}
