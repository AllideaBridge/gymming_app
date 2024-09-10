class TrainerAuth {
  final int _trainerId;
  final String _accessToken;
  final String _refreshToken;

  TrainerAuth(this._trainerId, this._accessToken, this._refreshToken);

  String get refreshToken => _refreshToken;

  String get accessToken => _accessToken;

  int get trainerId => _trainerId;
}
