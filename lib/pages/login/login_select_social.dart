import 'package:flutter/material.dart';
import 'package:gymming_app/pages/gympro/gympro_register.dart';
import 'package:gymming_app/pages/login/component/login_footer.dart';
import 'package:gymming_app/pages/login/component/login_header.dart';
import 'package:gymming_app/services/auth/token_manager_service.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';

import '../../common/colors.dart';
import '../../common/exceptions.dart';
import '../../services/auth/kakao_auth_service.dart';
import '../../services/models/trainer_auth.dart';
import '../../services/models/user_auth.dart';
import '../../services/repositories/auth_repository.dart';
import '../../state/info_state.dart';
import '../gymbie/gymbie_home/gymbie_home.dart';
import '../gymbie/gymbie_register.dart';
import '../gympro/gympro_home/gympro_home.dart';

class LoginSelectSocial extends StatelessWidget {
  const LoginSelectSocial({super.key, required this.loginType});

  final String loginType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/login_background.jpg"),
                fit: BoxFit.cover,
                opacity: 0.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LoginHeader(
                    subtitle: "맞춤형 PT 일정을\n계획해보세요.",
                  ),
                  Column(
                    children: [
                      buildKakaoLogin(context),
                      SizedBox(
                        height: 20,
                      ),
                      LoginFooter(),
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }

  Column buildKakaoLogin(BuildContext context) {
    final kakaoAuthService = KakaoAuthService();
    final authRepository = AuthRepository(client: http.Client());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                height: 1,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              "다음으로 로그인",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Container(
                height: 1,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        // KakaoLoginButton()
        ElevatedButton(
            onPressed: () async {
              OAuthToken? oAuthToken = await kakaoAuthService.signInWithKakao();
              if (oAuthToken != null) {
                if (loginType == "user") {
                  // todo : 로그인 api 먼저 호출 후 홈 화면 또는 회원 가입 화면으로 분기
                  try {
                    UserAuth userAuth =
                        await authRepository.signInUser(oAuthToken.accessToken);
                    Provider.of<InfoState>(context, listen: false)
                        .setUserId(userAuth.userId);
                    TokenManagerService.instance
                        .saveAccessToken(userAuth.accessToken);
                    TokenManagerService.instance
                        .saveRefreshToken(userAuth.refreshToken);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => GymbieHome()));
                  } on UserNotRegisteredException {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GymbieRegister(
                                  kakaoToken: oAuthToken.accessToken,
                                )));
                  }
                } else if (loginType == "trainer") {
                  // todo : 로그인 api 먼저 호출 후 홈 화면 또는 회원 가입 화면으로 분기
                  try {
                    TrainerAuth trainerAuth = await authRepository
                        .signInTrainer(oAuthToken.accessToken);
                    Provider.of<InfoState>(context, listen: false)
                        .setTrainerId(trainerAuth.trainerId);
                    TokenManagerService.instance
                        .saveAccessToken(trainerAuth.accessToken);
                    TokenManagerService.instance
                        .saveRefreshToken(trainerAuth.refreshToken);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => GymproHome()));
                  } on TrainerNotRegisteredException {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GymproRegister(
                                  kakaoToken: oAuthToken.accessToken,
                                )));
                  }
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: KAKAO_BACKGROUND_COLOR,
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
            ),
            child: Text('카카오로 시작하기',
                style: TextStyle(
                  color: INDICATOR_COLOR,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ))),
      ],
    );
  }
}
