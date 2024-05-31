class LessonList {
  final int _userId;
  final String _userName;
  final DateTime _startTime;
  final int _lessonMinute;

  LessonList(this._userId, this._userName, this._startTime, this._lessonMinute);

  int get userId => _userId;

  String get userName => _userName;

  DateTime get startTime => _startTime;

  int get lessonMinute => _lessonMinute;

  factory LessonList.fromJson(Map<String, dynamic> json, int lessonMinute) {
    return LessonList(json["user_id"], json["user_name"],
        DateTime.parse(json["schedule_start_time"]), lessonMinute);
  }

  static List<LessonList> parseLessonListList(Map<String, dynamic> body) {
    final List<LessonList> result = [];
    int lessonMinute = body["lesson_minute"];
    for (Map<String, dynamic> item in body["result"]) {
      result.add(LessonList.fromJson(item, lessonMinute));
    }
    return result;
  }
}
