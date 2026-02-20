abstract class DoctorAvailabilityDataSource {
  Future<bool> hasDoctorAvailableAt(DateTime dateTime);
}

class FakeDoctorAvailabilityDataSource implements DoctorAvailabilityDataSource {
  @override
  Future<bool> hasDoctorAvailableAt(DateTime dateTime) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));

    final weekday = dateTime.weekday;

    final isWeekday = weekday >= DateTime.monday && weekday <= DateTime.friday;
    if (!isWeekday) {
      return false;
    }

    return true;
  }
}
