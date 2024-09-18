class TokenRefreshFailedException implements Exception {
  final String message;

  TokenRefreshFailedException([this.message = 'Failed to refresh token']);

  @override
  String toString() => 'TokenRefreshFailedException: $message';
}

class UserNotRegisteredException implements Exception {
  final String message;
  UserNotRegisteredException([this.message = 'User not registered']);

  @override
  String toString() => message;
}

class TrainerNotRegisteredException implements Exception {
  final String message;
  TrainerNotRegisteredException([this.message = 'Trainer not registered']);

  @override
  String toString() => message;
}