import 'package:telemedicina_app/features/symptoms/data/datasources/reason_data_source.dart';
import 'package:telemedicina_app/features/symptoms/domain/entities/reason_item.dart';
import 'package:telemedicina_app/features/symptoms/domain/repositories/reason_repository.dart';

class ReasonRepositoryImpl implements ReasonRepository {
  ReasonRepositoryImpl({required this.dataSource});

  final ReasonDataSource dataSource;

  @override
  Future<List<ReasonItem>> getReasons() {
    return dataSource.getReasons();
  }

  @override
  Future<void> saveSymptoms({
    required List<String> selectedReasons,
    String? otherSymptoms,
  }) {
    return dataSource.saveSymptoms(
      selectedReasons: selectedReasons,
      otherSymptoms: otherSymptoms,
    );
  }
}
