import 'package:flutter/material.dart';
import 'package:gymming_app/pages/login/login_select_type.dart';

import '../../common/colors.dart';
import '../../components/profile_card.dart';
import 'component/login_header.dart';

class SignInSucceed extends StatelessWidget {
  final String type;
  final String imgUrl;
  final String name;
  final DateTime birth;
  final String gender;
  final String phoneNumber;

  const SignInSucceed({
    super.key,
    required this.type,
    required this.imgUrl,
    required this.name,
    required this.birth,
    required this.gender,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LoginHeader(
                    subtitle: "회원가입을\n완료하였습니다.",
                  ),
                  Image.asset('assets/images/change_completed.png'),
                  Column(
                    children: [
                      ProfileCard(
                          imgUrl: imgUrl,
                          name: name,
                          birth: birth,
                          gender: gender,
                          phoneNumber: phoneNumber),
                      SizedBox(
                        height: 40.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                //다시 첫 화면으로 돌아간다.
                                MaterialPageRoute(
                                    builder: (context) => LoginSelectType()),
                                (Route<dynamic> route) => false,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: PRIMARY_COLOR,
                              minimumSize: const Size.fromHeight(52),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                            ),
                            child: Text('GYMMING 시작하기',
                                style: TextStyle(
                                  color: INDICATOR_COLOR,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ))),
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
