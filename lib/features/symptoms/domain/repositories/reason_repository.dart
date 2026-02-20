import 'package:telemedicina_app/features/symptoms/domain/entities/reason_item.dart';

abstract class ReasonRepository {
  Future<List<ReasonItem>> getReasons();

  Future<void> saveSymptoms({
    required List<String> selectedReasons,
    String? otherSymptoms,
  });
}
