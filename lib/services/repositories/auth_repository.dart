import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../common/exceptions.dart';
import '../auth/api_service.dart';
import '../models/trainer_auth.dart';
import '../models/user_auth.dart';

class AuthRepository extends ApiService {
  AuthRepository({required this.client});

  final http.Client client;

  final String baseUrl = "http://10.0.2.2:5000/auth";

  Future<Map<String, dynamic>> getTokenType() async {
    try {
      final response = await makeAuthenticatedRequest(
          'GET', Uri.parse('$baseUrl/token-type-check'),
          headers: {
            'Content-Type': 'application/json',
          });

      if (response.statusCode == HttpStatus.ok) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData;
      } else {
        throw Exception('Failed to getTokenType');
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<UserAuth> signUpUser(
      Map<String, Object> params) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register/kakao/user'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(params),
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
        print('회원가입 실패: ${response}');
        throw Exception('Failed to sign up');
      }
    } catch (error) {
      print('회원가입 요청 중 에러 발생: $error');
      rethrow;
    }
  }

  Future<TrainerAuth> signUpTrainer(Map<String, Object> params) async{
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register/kakao/trainer'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(params),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // JSON에서 id와 access_token 추출
        int trainerId = responseData['trainer_id'];
        String accessToken = responseData['access_token'];
        String refreshToken = responseData['refresh_token'];

        return TrainerAuth(trainerId, accessToken, refreshToken);
      } else {
        print('트레이너 가입 실패: ${response.statusCode}');
        print('트레이너 가입 실패: ${response}');
        throw Exception('Failed to sign up');
      }
    } catch (error) {
      print('트레이너 가입 요청 중 에러 발생: $error');
      rethrow;
    }
  }


  Future<UserAuth> signInUser(
      String kakaoToken) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/login/kakao/user?kakao_token=$kakaoToken'),
        headers: {
          'Content-Type': 'application/json',
        }
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // JSON에서 id와 access_token 추출
        int userId = responseData['user_id'];
        String accessToken = responseData['access_token'];
        String refreshToken = responseData['refresh_token'];

        return UserAuth(userId, accessToken, refreshToken);
      } else if (response.statusCode == 401) {
        throw UserNotRegisteredException();
      } else {
        print('회원 로그인 실패: ${response.statusCode}');
        print('회원 로그인 실패: ${response}');
        throw Exception('Failed to sign In User');
      }
    } catch (error) {
      print('회원 로그인 중 에러 발생: $error');
      rethrow;
    }
  }

  Future<TrainerAuth> signInTrainer(String kakaoToken) async{
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/login/kakao/trainer?kakao_token=$kakaoToken'),
        headers: {
          'Content-Type': 'application/json',
        }
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // JSON에서 id와 access_token 추출
        int trainerId = responseData['trainer_id'];
        String accessToken = responseData['access_token'];
        String refreshToken = responseData['refresh_token'];

        return TrainerAuth(trainerId, accessToken, refreshToken);
      } else if (response.statusCode == 401) {
        throw TrainerNotRegisteredException();
      } else {
        print('트레이너 로그인 실패: ${response.statusCode}');
        print('트레이너 로그인 실패: ${response}');
        throw Exception('Failed to sign In Trainer');
      }
    } catch (error) {
      print('트레이너 로그인 중 에러 발생: $error');
      rethrow;
    }
  }
}
