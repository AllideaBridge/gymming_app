import 'package:flutter/material.dart';

import '../../common/colors.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _loginType = "";

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
                  buildLoginUpperSide(),
                  _loginType.isEmpty
                      ? buildLoginBottomSide()
                      : buildKakaoLogin()
                ]),
          ),
        ),
      ),
    );
  }

  Column buildLoginUpperSide() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "GYMMING",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          "맞춤형 PT 일정을\n계획해보세요.",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Column buildKakaoLogin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
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
            onPressed: () {},
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
        SizedBox(
          height: 20,
        ),
        buildLoginFooter()
      ],
    );
  }

  Column buildLoginBottomSide() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              setState(() {
                _loginType = "user";
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: PRIMARY_COLOR,
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
            ),
            child: Text('회원으로 시작하기',
                style: TextStyle(
                  color: INDICATOR_COLOR,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ))),
        SizedBox(
          height: 12,
        ),
        ElevatedButton(
            onPressed: () {
              setState(() {
                _loginType = "trainer";
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: BACKGROUND_COLOR,
              minimumSize: const Size.fromHeight(52),
              side: BorderSide(color: TERITARY_COLOR),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
            ),
            child: Text('트레이너로 시작하기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ))),
        SizedBox(
          height: 20,
        ),
        buildLoginFooter()
      ],
    );
  }

  Row buildLoginFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '개인정보 처리 방침',
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
        SizedBox(
          width: 12,
        ),
        Container(
          width: 1,
          height: 12,
          color: Colors.white,
        ),
        SizedBox(
          width: 12,
        ),
        Text(
          '이용 약관',
          style: TextStyle(fontSize: 12, color: Colors.white),
        )
      ],
    );
  }
}
