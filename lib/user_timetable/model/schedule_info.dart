class ScheduleInfo {
  DateTime _startTime;
  DateTime _endTime;
  String _lessonName;
  String _trainerName;
  String _centerName;
  String _centerLocation;
  int _remainDays;

  ScheduleInfo(this._startTime, this._endTime, this._lessonName,
      this._trainerName, this._centerName, this._centerLocation, this._remainDays);

  String get centerLocation => _centerLocation;

  String get centerName => _centerName;

  String get trainerName => _trainerName;

  String get lessonName => _lessonName;

  DateTime get endTime => _endTime;

  DateTime get startTime => _startTime;

  int get remainDays => _remainDays;
}
