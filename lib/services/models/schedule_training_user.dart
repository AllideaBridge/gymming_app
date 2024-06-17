class ScheduleTrainerUser {
  final int _scheduleId;
  final DateTime _startTime;

  ScheduleTrainerUser(
    this._scheduleId,
    this._startTime,
  );

  int get scheduleId => _scheduleId;

  DateTime get startTime => _startTime;

  factory ScheduleTrainerUser.fromJson(Map<String, dynamic> json) {
    return ScheduleTrainerUser(
      json["schedule_id"],
      DateTime.parse(json["schedule_start_time"]),
    );
  }

  static List<ScheduleTrainerUser> parseScheduleTrainingUserList(
      List<dynamic> body) {
    final List<ScheduleTrainerUser> result = [];
    for (Map<String, dynamic> item in body) {
      result.add(ScheduleTrainerUser.fromJson(item));
    }
    return result;
  }

  // api 완성되기 전 dummy 값
  static List<ScheduleTrainerUser> getDummyTrainerUserMonthlyScheduleList() {
    return [
      ScheduleTrainerUser(1, DateTime.parse('2024-05-17T09:00')),
      ScheduleTrainerUser(2, DateTime.parse('2024-05-18T10:00')),
      ScheduleTrainerUser(3, DateTime.parse('2024-05-19T11:00')),
    ];
  }
}
