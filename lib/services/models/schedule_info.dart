class ScheduleInfo {
  final int _scheduleId;
  final DateTime _startTime;
  final String _lessonName;
  final String _trainerName;
  final String _centerName;
  final String _centerLocation;
  final int _lessonChangeLimit;

  ScheduleInfo(
      this._scheduleId,
      this._startTime,
      this._lessonName,
      this._trainerName,
      this._centerName,
      this._centerLocation,
      this._lessonChangeLimit);

  int get scheduleId => _scheduleId;

  String get centerLocation => _centerLocation;

  String get centerName => _centerName;

  String get trainerName => _trainerName;

  String get lessonName => _lessonName;

  DateTime get startTime => _startTime;

  int get lessonChangeLimit => _lessonChangeLimit;

  factory ScheduleInfo.fromJson(Map<String, dynamic> json) {
    return ScheduleInfo(
        json["schedule_id"],
        DateTime.parse(json["schedule_start_time"]),
        json["lesson_name"],
        json["trainer_name"],
        json["center_name"],
        json["center_location"],
        int.parse(json["lesson_change_range"]));
  }
}
