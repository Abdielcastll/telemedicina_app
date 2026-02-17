import 'package:get/get.dart';
import 'package:telemedicina_app/core/routes/app_routes.dart';
import 'package:telemedicina_app/features/home/domain/usecases/check_doctor_availability_usecase.dart';

class HomeController extends GetxController {
  HomeController({required this.checkDoctorAvailabilityUseCase});

  final CheckDoctorAvailabilityUseCase checkDoctorAvailabilityUseCase;

  static const predefinedReasons = <String>[
    'Dolor de cabeza',
    'Gripe',
    'Fiebre',
    'Dolor estomacal',
    'Otro',
  ];

  final isLoading = true.obs;
  final hasDoctorAvailable = false.obs;
  final availabilityMessage = ''.obs;
  final selectedReason = predefinedReasons.first.obs;
  final otherSymptoms = ''.obs;

  @override
  void onInit() {
    super.onInit();
    checkAvailability();
  }

  bool get isOtherReasonSelected => selectedReason.value == 'Otro';

  Future<void> checkAvailability() async {
    isLoading.value = true;
    final requestedDateTime = _resolveRequestedDateTime();

    final available = await checkDoctorAvailabilityUseCase(requestedDateTime);
    hasDoctorAvailable.value = available;
    availabilityMessage.value = available
        ? ''
        : 'No hay doctores disponibles para el horario solicitado.\nHorario consultado: ${requestedDateTime.hour.toString().padLeft(2, '0')}:${requestedDateTime.minute.toString().padLeft(2, '0')}';

    isLoading.value = false;
  }

  DateTime _resolveRequestedDateTime() {
    final args = Get.arguments;

    if (args is Map<String, dynamic>) {
      final value = args['checkAt'];
      if (value is String) {
        final parsed = DateTime.tryParse(value);
        if (parsed != null) {
          return parsed;
        }
      }
    }

    return DateTime.now();
  }

  void setReason(String? reason) {
    if (reason == null || reason.isEmpty) return;
    selectedReason.value = reason;
    if (reason != 'Otro') {
      otherSymptoms.value = '';
    }
  }

  void submitConsultation() {
    if (isOtherReasonSelected && otherSymptoms.value.trim().isEmpty) {
      Get.snackbar(
        'Falta informacion',
        'Especifica los sintomas en el campo de texto.',
      );
      return;
    }

    Get.snackbar('Consulta registrada', 'Motivo guardado correctamente.');
  }

  void logout() {
    Get.offAllNamed(Routes.login);
  }
}
