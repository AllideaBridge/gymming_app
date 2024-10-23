import 'package:gymming_app/common/constants.dart';
import 'package:gymming_app/services/models/user_detail.dart';

import '../utils/date_util.dart';

class TrainerUserDetail {
  final String _name;
  final String? _email;
  final String _gender;
  final String _phoneNumber;
  final String? _userProfileImgUrl;
  final bool _deleteFlag;
  final DateTime _birthday;
  final int _lessonTotalCount;
  final int _lessonCurrentCount;
  final String _exerciseDays;
  final String _specialNotes;
  final DateTime _registeredDate;
  final DateTime? _lastDate;

  TrainerUserDetail(
      this._name,
      this._email,
      this._gender,
      this._phoneNumber,
      this._userProfileImgUrl,
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

  String? get userProfileImgUrl => _userProfileImgUrl;

  String get phoneNumber => _phoneNumber;

  String get gender => _gender == 'M' ? GENDER_MALE : GENDER_FEMALE;

  String? get email => _email;

  String get name => _name;

  DateTime get registeredDate => _registeredDate;

  DateTime? get lastDate => _lastDate;

  String getTrainerUserListDetailText(bool isPresent) {
    return '$_exerciseDays | $_lessonCurrentCount / $_lessonTotalCount 진행 |${DateUtil.convertDateTimeWithDash(isPresent ? _registeredDate : _lastDate!)} ${isPresent ? "등록" : "종료"}';
  }

  factory TrainerUserDetail.fromJson(Map<String, dynamic> json) {
    return TrainerUserDetail(
        json["name"],
        json["email"] ?? '',
        json["gender"],
        json["phone_number"],
        json["profile_img_url"],
        json["delete_flag"],
        DateTime.parse(json["birthday"]),
        json["lesson_total_count"],
        json["lesson_current_count"],
        json["exercise_days"],
        json["special_notice"],
        DateTime.parse(json["registered_date"]),
        DateTime.parse(json["last_date"]));
  }

  factory TrainerUserDetail.fromUser(UserDetail userDetail) {
    return TrainerUserDetail(
        userDetail.userName,
        userDetail.userEmail,
        userDetail.userGender,
        userDetail.userPhoneNumber,
        userDetail.userProfileImgUrl,
        userDetail.userDeleteFlag,
        DateTime.parse(userDetail.userBirthday),
        0,
        0,
        "",
        "",
        DateUtil.getKorTimeNow(),
        null);
  }
}
