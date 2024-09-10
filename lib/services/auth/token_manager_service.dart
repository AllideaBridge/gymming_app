import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:http/http.dart' as http;

import '../../common/constants.dart';

class TokenManagerService {
  final _storage = const FlutterSecureStorage();

  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  // 싱글톤 패턴 적용
  TokenManagerService._privateConstructor();

  static final TokenManagerService instance =
      TokenManagerService._privateConstructor();

  // 액세스 토큰 저장
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _accessTokenKey, value: token);
  }

  // 리프레시 토큰 저장
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _refreshTokenKey, value: token);
  }

  // 액세스 토큰 불러오기
  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  // 리프레시 토큰 불러오기
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  // 모든 토큰 삭제
  Future<void> clearTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }

  // 액세스 토큰의 유효성 검사
  Future<bool> isAccessTokenValid() async {
    final token = await getAccessToken();
    if (token == null) return false;

    try {
      return !Jwt.isExpired(token);
    } catch (e) {
      // 토큰 파싱 오류 처리, 로그 남기기
      print(e);
      return false;
    }
  }

  // 액세스 토큰 갱신
  Future<bool> refreshAccessToken() async {
    final refreshToken = await getRefreshToken();
    if (refreshToken == null) return false;

    final response = await http
        .get(Uri.parse('$SERVER_URL/auth/refresh'), // 실제 API 엔드포인트로 변경
            headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $refreshToken',
        });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await saveAccessToken(data[_accessTokenKey]);
      await saveRefreshToken(data[_refreshTokenKey]);
      return true;
    } else {
      // 리프레시 토큰이 만료되었거나 유효하지 않은 경우
      await clearTokens();
      return false;
    }
  }
}
