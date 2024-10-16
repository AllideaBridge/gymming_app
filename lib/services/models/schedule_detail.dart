class ScheduleDetail {
  final int _scheduleId;
  final DateTime _startTime;
  final String _lessonName;
  final String _trainerName;
  final String _centerName;
  final String _centerLocation;

  ScheduleDetail(
    this._scheduleId,
    this._startTime,
    this._lessonName,
    this._trainerName,
    this._centerName,
    this._centerLocation,
  );

  int get scheduleId => _scheduleId;

  DateTime get startTime => _startTime;

  String get lessonName => _lessonName;

  String get trainerName => _trainerName;

  String get centerName => _centerName;

  String get centerLocation => _centerLocation;

  factory ScheduleDetail.fromJson(Map<String, dynamic> json) {
    return ScheduleDetail(
      json["schedule_id"],
      DateTime.parse(json["schedule_start_time"]),
      json["lesson_name"],
      json["trainer_name"],
      json["center_name"],
      json["center_location"],
    );
  }
}
