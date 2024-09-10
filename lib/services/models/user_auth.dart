class UserAuth {
  final int _userId;
  final String _accessToken;
  final String _refreshToken;

  UserAuth(this._userId, this._accessToken, this._refreshToken);

  String get refreshToken => _refreshToken;

  String get accessToken => _accessToken;

  int get userId => _userId;
}
