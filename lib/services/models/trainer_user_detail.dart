import 'package:gymming_app/common/constants.dart';

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
      this._specialNotes);

  String get specialNotes => _specialNotes;

  String get exerciseDays => _exerciseDays;

  int get lessonCurrentCount => _lessonCurrentCount;

  int get lessonTotalCount => _lessonTotalCount;

  DateTime get birthday => _birthday;

  String get loginPlatform => _loginPlatform;

  String get profileImgUrl => _profileImgUrl;

  String get phoneNumber => _phoneNumber;

  String get gender => _gender;

  String get email => _email;

  String get name => _name;

// api 완성되기 전 dummy 값
  static TrainerUserDetail getDummyTrainerUserDetail() {
    return TrainerUserDetail(
        'john',
        'example.com',
        GENDER_MALE,
        '010-1234-5678',
        'text.com',
        SOCIAL_KAKAO,
        false,
        DateTime(1997, 11, 10),
        10,
        3,
        '월, 수, 금',
        '없음');
  }
}
