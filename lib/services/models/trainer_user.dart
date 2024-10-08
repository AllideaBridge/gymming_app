import '../utils/date_util.dart';

class TrainerUser {
  final int _userId;
  final String _userName;
  final String? _userProfileImgUrl;
  final String _exerciseDays;
  final int _lessonCurrentCount;
  final int _lessonTotalCount;
  final DateTime _registeredDate;
  final DateTime _lastDate;

  TrainerUser(
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

  String? get userProfileImgUrl => _userProfileImgUrl;

  String get exerciseDays => _exerciseDays;

  int get lessonCurrentCount => _lessonCurrentCount;

  int get lessonTotalCount => _lessonTotalCount;

  DateTime get registeredDate => _registeredDate;

  DateTime get lastDate => _lastDate;

  String getTrainerUserListDetailText(bool isPresent) {
    return '$_exerciseDays | $_lessonCurrentCount / $_lessonTotalCount 진행 |${DateUtil.convertDateTimeWithDash(isPresent ? _registeredDate : _lastDate)} ${isPresent ? "등록" : "종료"}';
  }

  factory TrainerUser.fromJson(Map<String, dynamic> json) {
    return TrainerUser(
        json["user_id"],
        json["user_name"],
        json["user_profile_img_url"],
        json["exercise_days"],
        json["lesson_current_count"],
        json["lesson_total_count"],
        DateTime.parse(json["registered_date"]),
        DateTime.parse(json["last_date"]));
  }

  static List<TrainerUser> parseTrainerUserList(List<dynamic> body) {
    final List<TrainerUser> result = [];
    for (Map<String, dynamic> item in body) {
      result.add(TrainerUser.fromJson(item));
    }
    return result;
  }
}
