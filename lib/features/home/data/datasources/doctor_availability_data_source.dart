abstract class DoctorAvailabilityDataSource {
  Future<bool> hasDoctorAvailableAt(DateTime dateTime);
}

class FakeDoctorAvailabilityDataSource implements DoctorAvailabilityDataSource {
  @override
  Future<bool> hasDoctorAvailableAt(DateTime dateTime) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));

    final weekday = dateTime.weekday;
    final hour = dateTime.hour;

    final isWeekday = weekday >= DateTime.monday && weekday <= DateTime.friday;
    if (!isWeekday) {
      return false;
    }

    final isMorningShift = hour >= 8 && hour < 12;
    final isAfternoonShift = hour >= 14 && hour < 18;
    return isMorningShift || isAfternoonShift;
  }
}
