import 'package:get/get.dart';
import 'package:telemedicina_app/core/routes/app_routes.dart';
import 'package:telemedicina_app/features/settings/_export.dart';
import 'package:telemedicina_app/features/symptoms/_export.dart';

class SymptomsController extends GetxController {
  SymptomsController({
    required this.checkDoctorAvailabilityUseCase,
    required this.getReasonsUseCase,
    required this.saveSymptomsUseCase,
  });

  final CheckDoctorAvailabilityUseCase checkDoctorAvailabilityUseCase;
  final GetReasonsUseCase getReasonsUseCase;
  final SaveSymptomsUseCase saveSymptomsUseCase;

  static const String otherReasonLabel = 'Otro';

  final isLoading = true.obs;
  final hasDoctorAvailable = false.obs;
  final availabilityMessage = ''.obs;
  final reasonsLoadMessage = ''.obs;
  final reasons = <String>[].obs;
  final selectedReasons = <String>[].obs;
  final otherSymptoms = ''.obs;
  final isSaving = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  bool get isOtherReasonSelected => selectedReasons.contains(otherReasonLabel);

  Future<void> _initializeData() async {
    isLoading.value = true;

    await checkAvailability(showLoading: false);

    if (hasDoctorAvailable.value) {
      await loadReasons();
    } else {
      reasons.clear();
      selectedReasons.clear();
      otherSymptoms.value = '';
    }

    isLoading.value = false;
  }

  Future<void> checkAvailability({bool showLoading = true}) async {
    if (showLoading) {
      isLoading.value = true;
    }

    final requestedDateTime = _resolveRequestedDateTime();

    final available = await checkDoctorAvailabilityUseCase(requestedDateTime);
    hasDoctorAvailable.value = available;
    availabilityMessage.value = available
        ? ''
        : 'No hay doctores disponibles para el horario solicitado.\nHorario consultado: ${requestedDateTime.hour.toString().padLeft(2, '0')}:${requestedDateTime.minute.toString().padLeft(2, '0')}';

    if (showLoading) {
      isLoading.value = false;
    }
  }

  Future<void> loadReasons() async {
    try {
      final fetchedReasons = await getReasonsUseCase();
      final reasonNames = fetchedReasons
          .map((reason) => reason.name.trim())
          .where((name) => name.isNotEmpty)
          .toList();

      if (reasonNames.isEmpty) {
        throw StateError('La API devolvio una lista vacia de motivos.');
      }

      reasons.assignAll(reasonNames);
      reasonsLoadMessage.value = '';
    } catch (_) {
      reasons.clear();
      reasonsLoadMessage.value =
          'No se pudieron cargar los motivos desde el servidor.';
      Get.snackbar('Aviso', reasonsLoadMessage.value);
    }

    if (reasons.isEmpty) {
      selectedReasons.clear();
      otherSymptoms.value = '';
      return;
    }

    selectedReasons.removeWhere((reason) => !reasons.contains(reason));

    if (!isOtherReasonSelected) {
      otherSymptoms.value = '';
    }
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

  void toggleReason(String reason, bool selected) {
    if (reason.isEmpty) return;

    if (selected) {
      if (!selectedReasons.contains(reason)) {
        selectedReasons.add(reason);
      }
      return;
    }

    selectedReasons.remove(reason);
    if (reason == otherReasonLabel) {
      otherSymptoms.value = '';
    }
  }

  Future<void> submitConsultation() async {
    if (isSaving.value) return;

    if (selectedReasons.isEmpty) {
      Get.snackbar('Falta informacion', 'Selecciona al menos un sintoma.');
      return;
    }

    if (isOtherReasonSelected && otherSymptoms.value.trim().isEmpty) {
      Get.snackbar(
        'Falta informacion',
        'Especifica los sintomas en el campo de texto.',
      );
      return;
    }

    isSaving.value = true;
    try {
      await saveSymptomsUseCase(
        selectedReasons: selectedReasons.toList(growable: false),
        otherSymptoms: isOtherReasonSelected
            ? otherSymptoms.value.trim()
            : null,
      );

      Get.snackbar('Consulta registrada', 'Sintomas guardados correctamente.');

      final settingsService = Get.isRegistered<SettingsService>()
          ? Get.find<SettingsService>()
          : null;
      final mostrarSignosVitales =
          settingsService?.getBool('SIGNOS_VITALES') ?? false;

      if (mostrarSignosVitales) {
        Get.toNamed(Routes.vitalSignsCapture);
      } else {
        Get.toNamed(Routes.videoCall);
      }
    } catch (_) {
      Get.snackbar('Error', 'No fue posible guardar los sintomas.');
    } finally {
      isSaving.value = false;
    }
  }

  void logout() {
    Get.offAllNamed(Routes.login);
  }
}
