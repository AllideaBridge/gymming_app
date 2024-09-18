import 'package:flutter/material.dart';
import 'package:gymming_app/components/modals/basic_modal.dart';
import 'package:gymming_app/pages/gymbie/gymbie_home/gymbie_home.dart';

import '../../common/colors.dart';
import '../../components/profile_card.dart';
import '../gympro/gympro_home/gympro_home.dart';
import 'component/login_header.dart';

class SignInSuccess extends StatelessWidget {
  final String type;
  final String imgUrl;
  final String name;
  final DateTime birth;
  final String gender;
  final String phoneNumber;
  final String? additionalTitle;
  final List<Widget>? additionalSub;

  const SignInSuccess({
    super.key,
    required this.type,
    required this.imgUrl,
    required this.name,
    required this.birth,
    required this.gender,
    required this.phoneNumber,
    this.additionalTitle,
    this.additionalSub,
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
                        phoneNumber: phoneNumber,
                        additionalTitle: additionalTitle,
                        additionalSub: additionalSub,
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  barrierColor: Colors.black.withOpacity(0.7),
                                  builder: (context) => BasicModal(
                                      title: '회원가입 완료',
                                      content: _buildModalContent(),
                                      onConfirm: () {
                                        if (type == 'trainer') {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    GymproHome()),
                                            (Route<dynamic> route) => false,
                                          );
                                          return;
                                        }
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  GymbieHome()),
                                          (Route<dynamic> route) => false,
                                        );
                                      }));
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

  Widget _buildModalContent() {
    if (type == 'trainer') {
      return Text.rich(
        TextSpan(
          style: TextStyle(color: Colors.white, fontSize: 16),
          children: <TextSpan>[
            TextSpan(
              text: '환영합니다, ',
              style: TextStyle(color: PRIMARY_COLOR, fontSize: 16),
            ),
            TextSpan(
              text: '$name 트레이너님 🤗\n\n',
            ),
            TextSpan(
              text: 'Gymming',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: '은 일정 변경 자동 승인 정책을 지원합니다.\n\n',
            ),
            TextSpan(
              text: '기본값인 ',
            ),
            TextSpan(
              text: '7일',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: '로 설정되어 있지만 이 설정은 언제든지 변경할 수 있습니다.\n\n',
            ),
            TextSpan(
              text: '좌측 상단 메뉴의 ',
            ),
            TextSpan(
              text: '[정책 변경]',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: '에서 더 자세한 내용을 확인하세요 🙏',
            ),
          ],
        ),
      );
    } else {
      return Text.rich(
        TextSpan(
          style: TextStyle(color: Colors.white, fontSize: 16),
          children: <TextSpan>[
            TextSpan(
              text: '환영합니다, ',
              style: TextStyle(color: PRIMARY_COLOR, fontSize: 16),
            ),
            TextSpan(
              text: '$name님 🤗\n\n',
            ),
            TextSpan(
              text: 'Gymming',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text:
                  '트레이너와 회원이 함께 하는 플랫폼입니다.\n\n함께 할 트레이너에게 연결을 요청하세요.\n\n$name님의 새로운 여정에 항상 함께하겠습니다 🥳',
            ),
          ],
        ),
      );
    }
  }
}
