import 'package:equatable/equatable.dart';

class SettingException extends Equatable {
  const SettingException({
    required this.settingExceptionId,
    required this.name,
    required this.displayName,
    required this.value,
  });

  final int settingExceptionId;
  final String name;
  final String displayName;
  final String value;

  @override
  List<Object> get props => [settingExceptionId, name, displayName, value];
}
