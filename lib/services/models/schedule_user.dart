class ScheduleUser {
  final int _scheduleId;
  final int _trainerId;
  final DateTime _startTime;
  final String _lessonName;
  final String _trainerName;
  final String _centerName;
  final String _centerLocation;
  final int _lessonChangeRange;
  final int _lessonMinutes;

  ScheduleUser(
      this._scheduleId,
      this._trainerId,
      this._startTime,
      this._lessonName,
      this._trainerName,
      this._centerName,
      this._centerLocation,
      this._lessonChangeRange,
      this._lessonMinutes);

  int get scheduleId => _scheduleId;

  int get trainerId => _trainerId;

  String get centerLocation => _centerLocation;

  String get centerName => _centerName;

  String get trainerName => _trainerName;

  String get lessonName => _lessonName;

  DateTime get startTime => _startTime;

  int get lessonChangeRange => _lessonChangeRange;

  int get lessonMinutes => _lessonMinutes;

  factory ScheduleUser.fromJson(Map<String, dynamic> json) {
    return ScheduleUser(
        json["schedule_id"],
        json["trainer_id"],
        DateTime.parse(json["schedule_start_time"]),
        json["lesson_name"],
        json["trainer_name"],
        json["center_name"],
        json["center_location"],
        json["lesson_change_range"],
        json["lesson_minutes"]); //아직 lesson_change_range 는 들어오지 않는다.
  }

  static List<ScheduleUser> parseScheduleDetailList(List<dynamic> body) {
    final List<ScheduleUser> result = [];
    for (Map<String, dynamic> item in body) {
      result.add(ScheduleUser.fromJson(item));
    }
    return result;
  }
}
