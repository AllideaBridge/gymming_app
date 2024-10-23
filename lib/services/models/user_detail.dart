class UserDetail {
  final int _userId;
  final String? _userEmail;
  final String _userName;
  final String _userGender;
  final String _userPhoneNumber;
  final String? _userProfileImgUrl;
  final bool _userDeleteFlag;
  final String _userBirthday;

  UserDetail(
      this._userId,
      this._userEmail,
      this._userName,
      this._userGender,
      this._userPhoneNumber,
      this._userProfileImgUrl,
      this._userDeleteFlag,
      this._userBirthday);

  String get userBirthday => _userBirthday;

  bool get userDeleteFlag => _userDeleteFlag;

  String? get userProfileImgUrl => _userProfileImgUrl;

  String get userPhoneNumber => _userPhoneNumber;

  String get userGender => _userGender;

  String get userName => _userName;

  String? get userEmail => _userEmail;

  int get userId => _userId;

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    return UserDetail(
        json['id'],
        json['email'],
        json['name'],
        json['gender'],
        json['phone_number'],
        json['user_profile_img_url'],
        json['delete_flag'],
        json['birthday']);
  }
}
