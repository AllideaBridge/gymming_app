import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:flutter/services.dart';

class KakaoAuthService {
  Future<OAuthToken?> signInWithKakao() async {
    try {
      OAuthToken oAuthToken;

      if (await isKakaoTalkInstalled()) {
        try {
          oAuthToken = await UserApi.instance.loginWithKakaoTalk();
          print('카카오톡으로 로그인 성공');
        } catch (error) {
          if (error is PlatformException && error.code == 'CANCELED') {
            return null; // 로그인 취소 처리
          }
          // 카카오톡 로그인 실패 시, 카카오 계정으로 로그인 시도
          oAuthToken = await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공');
        }
      } else {
        // 카카오톡이 설치되지 않은 경우, 카카오 계정으로 로그인 시도
        oAuthToken = await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공');
      }

      // 로그인 성공 시 토큰 반환
      return oAuthToken;
    } catch (error) {
      print('로그인 실패 $error');
      return null;
    }
  }

  Future<User?> getUserInfo() async {
    try {
      User user = await UserApi.instance.me();
      return user;
    } catch (error) {
      print('사용자 정보 가져오기 실패 $error');
      return null;
    }
  }
}