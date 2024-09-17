class TokenRefreshFailedException implements Exception {
  final String message;

  TokenRefreshFailedException([this.message = 'Failed to refresh token']);

  @override
  String toString() => 'TokenRefreshFailedException: $message';
}