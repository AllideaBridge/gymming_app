import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class KakaoLoginButton extends StatelessWidget {
  const KakaoLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          print(await KakaoSdk.origin);
          if (await isKakaoTalkInstalled()) {
            try {
              await UserApi.instance.loginWithKakaoTalk();
              print('카카오톡으로 로그인 성공');
            } catch (error) {
              print('카카오톡으로 로그인 실패 $error');

              // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
              // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
              if (error is PlatformException && error.code == 'CANCELED') {
                return;
              }
              // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
              try {
                await UserApi.instance.loginWithKakaoAccount();
                print('카카오계정으로 로그인 성공');
              } catch (error) {
                print('카카오계정으로 로그인 실패 $error');
              }
            }
          } else {
            try {
              var oAuthToken = await UserApi.instance.loginWithKakaoAccount();
              print(oAuthToken.accessToken);
              print(TokenManagerProvider.instance.manager.getToken());
              print('카카오계정으로 로그인 성공');
              User user = await UserApi.instance.me();
              print(user.kakaoAccount);
            } catch (error) {
              print('카카오계정으로 로그인 실패 $error');
            }
          }
        },
        child: Image.asset('assets/images/kakao_login.png'));
  }
}