class TrainingUser {
  final int _userId;
  final String _userName;
  final String _userProfileImgUrl;
  final List<String> _exerciseDays;
  final int _lessonCurrentCount;
  final int _lessonTotalCount;
  final DateTime _registeredDate;
  final DateTime _lastDate;

  TrainingUser(
      this._userId,
      this._userName,
      this._userProfileImgUrl,
      this._exerciseDays,
      this._lessonCurrentCount,
      this._lessonTotalCount,
      this._registeredDate,
      this._lastDate);

  int get userId => _userId;

  String get userName => _userName;

  String get userProfileImgUrl => _userProfileImgUrl;

  List<String> get exerciseDays => _exerciseDays;

  int get lessonCurrentCount => _lessonCurrentCount;

  int get lessonTotalCount => _lessonTotalCount;

  DateTime get registeredDate => _registeredDate;

  DateTime get lastDate => _lastDate;

  factory TrainingUser.fromJson(Map<String, dynamic> json) {
    return TrainingUser(
        json["user_id"],
        json["user_name"],
        json["user_profile_img_url"],
        json["exercise_days"].split(','),
        json["lesson_current_count"],
        json["lesson_total_count"],
        DateTime.parse(json["registered_date"]),
        DateTime.parse(json["last_date"]));
  }

  static List<TrainingUser> parseTrainingUserList(List<dynamic> body) {
    final List<TrainingUser> result = [];
    for (Map<String, dynamic> item in body) {
      result.add(TrainingUser.fromJson(item));
    }
    return result;
  }

  // api 완성되기 전 dummy 값
  static List<TrainingUser> getDummyTrainingUserList() {
    return [
      TrainingUser(
          1,
          "John Doe",
          "http://example.com/john",
          ["월", "수", "금"],
          5,
          10,
          DateTime.parse('2024-05-15T13:00:00'),
          DateTime.parse('2024-08-15T13:00:00')),
      TrainingUser(
          3,
          "test uer 2",
          "http://example.com/john",
          ["화", "목", "토"],
          5,
          10,
          DateTime.parse('2024-06-15T13:00:00'),
          DateTime.parse('2024-09-15T13:00:00'))
    ];
  }
}
