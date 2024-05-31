class ScheduleTrainingUser {
  final int _scheduleId;
  final DateTime _startTime;

  ScheduleTrainingUser(
    this._scheduleId,
    this._startTime,
  );

  int get scheduleId => _scheduleId;

  DateTime get startTime => _startTime;

  factory ScheduleTrainingUser.fromJson(Map<String, dynamic> json) {
    return ScheduleTrainingUser(
      json["schedule_id"],
      DateTime.parse(json["schedule_start_time"]),
    );
  }

  static List<ScheduleTrainingUser> parseScheduleTrainingUserList(
      List<dynamic> body) {
    final List<ScheduleTrainingUser> result = [];
    for (Map<String, dynamic> item in body) {
      result.add(ScheduleTrainingUser.fromJson(item));
    }
    return result;
  }

  // api 완성되기 전 dummy 값
  static List<ScheduleTrainingUser> getDummyTrainingUserMonthlyScheduleList() {
    return [
      ScheduleTrainingUser(1, DateTime.parse('2024-05-17T09:00')),
      ScheduleTrainingUser(2, DateTime.parse('2024-05-18T10:00')),
      ScheduleTrainingUser(3, DateTime.parse('2024-05-19T11:00')),
    ];
  }
}
