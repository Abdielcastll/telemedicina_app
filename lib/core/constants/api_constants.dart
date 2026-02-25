class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://telemedicinaapi.indautosoft.dev';

  static const String userExternalLoginPath =
      '/UserExternal/login/app'; // Autentica en la app
  static const String patientCreatePath =
      '/Patient/patients/create'; // Crea/actualiza paciente y retorna JWT
  static const String reasonGetAllPath =
      '/Reason/reason/getAll'; // Obtener todos los motivos de consultas
  static const String settingExceptionByTypePath =
      '/Setting/exceptions/getTypeSettingException'; // Obtener todas las configuraciones
}
