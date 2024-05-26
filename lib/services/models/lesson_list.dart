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
    int lessonMinute = int.parse(body["lesson_minute"]);
    for (Map<String, dynamic> item in body["result"]) {
      result.add(LessonList.fromJson(item, lessonMinute));
    }
    return result;
  }

  //api 완성되기 전 dummy 값
  static List<LessonList> getDummyLessonListList() {
    return [
      LessonList(1, "조성민", DateTime.parse('2024-05-24T13:00:00'), 60),
      LessonList(1, "김성관", DateTime.parse('2024-05-24T15:00:00'), 60),
      LessonList(1, "조성민", DateTime.parse('2024-05-25T13:00:00'), 60),
      LessonList(1, "김성관", DateTime.parse('2024-05-25T15:00:00'), 60),
      LessonList(1, "김도균", DateTime.parse('2024-05-26T13:00:00'), 120),
    ];
  }
}
