import 'package:gymming_app/common/constants.dart';

import '../utils/date_util.dart';

class TrainerUserDetail {
  final String _name;
  final String _email;
  final String _gender;
  final String _phoneNumber;
  final String _profileImgUrl;
  final String _loginPlatform;
  final bool _deleteFlag;
  final DateTime _birthday;
  final int _lessonTotalCount;
  final int _lessonCurrentCount;
  final String _exerciseDays;
  final String _specialNotes;
  final DateTime _registeredDate;
  final DateTime _lastDate;

  TrainerUserDetail(
      this._name,
      this._email,
      this._gender,
      this._phoneNumber,
      this._profileImgUrl,
      this._loginPlatform,
      this._deleteFlag,
      this._birthday,
      this._lessonTotalCount,
      this._lessonCurrentCount,
      this._exerciseDays,
      this._specialNotes,
      this._registeredDate,
      this._lastDate);

  String get specialNotes => _specialNotes;

  String get exerciseDays => _exerciseDays;

  int get lessonCurrentCount => _lessonCurrentCount;

  int get lessonTotalCount => _lessonTotalCount;

  DateTime get birthday => _birthday;

  String get loginPlatform => _loginPlatform;

  String get profileImgUrl => _profileImgUrl;

  String get phoneNumber => _phoneNumber;

  String get gender => _gender == 'M' ? GENDER_MALE : GENDER_FEMALE;

  String get email => _email;

  String get name => _name;

  DateTime get registeredDate => _registeredDate;

  DateTime get lastDate => _lastDate;

  String getTrainerUserListDetailText(bool isPresent) {
    return '$_exerciseDays | $_lessonCurrentCount / $_lessonTotalCount 진행 |${DateUtil.convertDateTimeWithDash(isPresent ? _registeredDate : _lastDate)} ${isPresent ? "등록" : "종료"}';
  }

  factory TrainerUserDetail.fromJson(Map<String, dynamic> json) {
    return TrainerUserDetail(
        json["name"],
        json["email"],
        json["gender"],
        json["phone_number"],
        json["profile_img_url"],
        json["login_platform"],
        json["delete_flag"],
        DateTime.parse(json["birthday"]),
        json["lesson_total_count"],
        json["lesson_current_count"],
        json["exercise_days"],
        json["special_notice"],
        DateTime.parse(json["registered_date"]),
        DateTime.parse(json["last_date"]));
  }

// api 완성되기 전 dummy 값
  static TrainerUserDetail getDummyTrainerUserDetail() {
    return TrainerUserDetail(
        'john',
        'example.com',
        'M',
        '010-1234-5678',
        "assets/images/trainerExample.png",
        SOCIAL_KAKAO,
        false,
        DateTime(1997, 11, 10),
        10,
        3,
        '월, 수, 금',
        '없음',
        DateTime.parse('2024-05-15T13:00:00'),
        DateTime.parse('2024-02-15T13:00:00'));
  }
}
