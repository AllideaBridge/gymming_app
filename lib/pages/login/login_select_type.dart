import 'package:flutter/material.dart';
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
                  LoginHeader(),
                  Column(
                    children: [
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
