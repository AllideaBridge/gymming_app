import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user_auth.dart';

class AuthRepository {
  AuthRepository({required this.client});

  final http.Client client;

  final String baseUrl = "http://10.0.2.2:5000/auth";

  Future<UserAuth> signUpUser(String accessToken) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/kakao/user'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'kakao_token': accessToken
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // JSON에서 id와 access_token 추출
        int userId = responseData['user_id'];
        String accessToken = responseData['access_token'];
        String refreshToken = responseData['refresh_token'];

        return UserAuth(userId, accessToken, refreshToken);

      } else {
        print('회원가입 실패: ${response.statusCode}');
        throw Exception('Failed to sign up');
      }
    } catch (error) {
      print('회원가입 요청 중 에러 발생: $error');
      rethrow;
    }
  }
}