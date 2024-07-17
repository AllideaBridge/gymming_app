import 'package:flutter/material.dart';
import 'package:gymming_app/pages/gymbie/gymbie_home/gymbie_home.dart';
import 'package:gymming_app/pages/login/component/login_footer.dart';
import 'package:gymming_app/pages/login/component/login_header.dart';

import '../../common/colors.dart';

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
                  LoginHeader(),
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
        ElevatedButton(
            onPressed: () {
              if (loginType == "user") {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => GymbieHome()),
                    (route) => false);
              } else if (loginType == "trainer") {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => GymbieHome()),
                    (route) => false);
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