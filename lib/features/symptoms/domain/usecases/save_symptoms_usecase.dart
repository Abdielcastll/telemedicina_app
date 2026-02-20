import 'package:telemedicina_app/features/symptoms/domain/repositories/reason_repository.dart';

class SaveSymptomsUseCase {
  SaveSymptomsUseCase(this.repository);

  final ReasonRepository repository;

  Future<void> call({
    required List<String> selectedReasons,
    String? otherSymptoms,
  }) {
    return repository.saveSymptoms(
      selectedReasons: selectedReasons,
      otherSymptoms: otherSymptoms,
    );
  }
}
