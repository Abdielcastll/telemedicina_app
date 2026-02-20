import 'package:telemedicina_app/features/symptoms/domain/entities/reason_item.dart';
import 'package:telemedicina_app/features/symptoms/domain/repositories/reason_repository.dart';

class GetReasonsUseCase {
  GetReasonsUseCase(this.repository);

  final ReasonRepository repository;

  Future<List<ReasonItem>> call() {
    return repository.getReasons();
  }
}
