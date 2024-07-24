import 'package:flutter/material.dart';
import 'package:gymming_app/pages/gymbie/gymbie_home/gymbie_home.dart';
import 'package:gymming_app/pages/login/component/login_footer.dart';
import 'package:gymming_app/pages/login/component/login_header.dart';
import 'package:gymming_app/pages/login/login_select_social.dart';

import '../../common/colors.dart';

class LoginSelectType extends StatelessWidget {
  const LoginSelectType({super.key});

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
                      //todo 임시 홈화면 이동
                      buildTestGymbiHome(context),
                      buildTypeSelect(context),
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

  Padding buildTestGymbiHome(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              //다시 첫 화면으로 돌아간다.
              MaterialPageRoute(builder: (context) => GymbieHome()),
              (Route<dynamic> route) => false,
            );
          },
          child: Text("테스트: 회원 홈화면")),
    );
  }

  Column buildTypeSelect(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginSelectSocial(
                            loginType: "user",
                          )));
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginSelectSocial(
                            loginType: "trainer",
                          )));
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
                )))
      ],
    );
  }
}
