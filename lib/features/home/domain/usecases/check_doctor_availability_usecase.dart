import '../repositories/doctor_availability_repository.dart';

class CheckDoctorAvailabilityUseCase {
  CheckDoctorAvailabilityUseCase(this.repository);

  final DoctorAvailabilityRepository repository;

  Future<bool> call(DateTime dateTime) {
    return repository.hasDoctorAvailableAt(dateTime);
  }
}
