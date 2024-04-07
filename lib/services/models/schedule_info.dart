class ScheduleInfo {
  final int _scheduleId;
  final DateTime _startTime;
  final DateTime _endTime;
  final String _lessonName;
  final String _trainerName;
  final String _centerName;
  final String _centerLocation;
  final int _remainDays;


  ScheduleInfo(this._scheduleId, this._startTime, this._endTime, this._lessonName,
      this._trainerName, this._centerName, this._centerLocation, this._remainDays);

  int get scheduleId => _scheduleId;
  String get centerLocation => _centerLocation;
  String get centerName => _centerName;
  String get trainerName => _trainerName;
  String get lessonName => _lessonName;
  DateTime get endTime => _endTime;
  DateTime get startTime => _startTime;
  int get remainDays => _remainDays;

  factory ScheduleInfo.fromJson(Map<String, dynamic> json) {
    return ScheduleInfo(
        json["schedule_id"],
        DateTime.parse(json["schedule_start_time"]),
        DateTime.parse(json["schedule_start_time"]),
        //todo endTime
        json["lesson_name"],
        json["trainer_name"],
        json["center_name"],
        json["center_location"],
        5);
  }
}
