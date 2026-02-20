import '../../domain/repositories/doctor_availability_repository.dart';
import '../datasources/doctor_availability_data_source.dart';

class DoctorAvailabilityRepositoryImpl implements DoctorAvailabilityRepository {
  DoctorAvailabilityRepositoryImpl({required this.dataSource});

  final DoctorAvailabilityDataSource dataSource;

  @override
  Future<bool> hasDoctorAvailableAt(DateTime dateTime) {
    return dataSource.hasDoctorAvailableAt(dateTime);
  }
}
