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

  static Set<ScheduleTrainerUser> parseScheduleTrainingUserList(
      List<dynamic> body) {
    final List<ScheduleTrainerUser> result = [];
    for (Map<String, dynamic> item in body) {
      result.add(ScheduleTrainerUser.fromJson(item));
    }
    return result.toSet();
  }
}
