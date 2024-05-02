class ScheduleDetail {
  final int _scheduleId;
  final DateTime _startTime;
  final String _lessonName;
  final String _trainerName;
  final String _centerName;
  final String _centerLocation;
  final int _lessonChangeRange;

  ScheduleDetail(
      this._scheduleId,
      this._startTime,
      this._lessonName,
      this._trainerName,
      this._centerName,
      this._centerLocation,
      this._lessonChangeRange);

  int get scheduleId => _scheduleId;

  String get centerLocation => _centerLocation;

  String get centerName => _centerName;

  String get trainerName => _trainerName;

  String get lessonName => _lessonName;

  DateTime get startTime => _startTime;

  int get lessonChangeRange => _lessonChangeRange;

  factory ScheduleDetail.fromJson(Map<String, dynamic> json) {
    return ScheduleDetail(
        json["schedule_id"],
        DateTime.parse(json["schedule_start_time"]),
        json["lesson_name"],
        json["trainer_name"],
        json["center_name"],
        json["center_location"],
        json["lesson_change_range"]); //아직 lesson_change_range 는 들어오지 않는다.
  }

  static List<ScheduleDetail> parseScheduleDetailList(List<dynamic> body) {
    final List<ScheduleDetail> result = [];
    for (Map<String, dynamic> item in body) {
      result.add(ScheduleDetail.fromJson(item));
    }
    return result;
  }
}
