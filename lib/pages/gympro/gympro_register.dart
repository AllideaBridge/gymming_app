import 'package:flutter/material.dart';
import 'package:gymming_app/components/buttons/primary_button.dart';
import 'package:gymming_app/components/buttons/secondary_button.dart';
import 'package:gymming_app/components/common_header.dart';
import 'package:gymming_app/components/layouts/gympro_infos/gympro_info_step1.dart';
import 'package:gymming_app/components/layouts/gympro_infos/gympro_info_step2.dart';
import 'package:gymming_app/components/layouts/gympro_infos/gympro_info_step3.dart';

class GymproRegister extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GymproRegisterState();
}

class GymproRegisterState extends State<GymproRegister> {
  final Map<String, dynamic> _model_step1 = {
    'name': '',
    'phoneNumber': '',
    'birth': DateTime.now(),
    'gender': 'M',
    'history': '',
  };
  int _currentStep = 0;

  void _nextStep() {
    setState(() {
      if (_currentStep < 2) {
        _currentStep++;
      }
    });
  }

  void _previousStep() {
    setState(() {
      if (_currentStep > 0) {
        _currentStep--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          CommonHeader(
            title: '트레이너로 가입',
            onPressed: () {
              print('돌아가기');
              // Navigator.pushAndRemoveUntil(
              //   context,
              //   MaterialPageRoute(builder: (context) => GymproRegisterCompleted()),
              //       (Route<dynamic> route) => false,
              // );
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: IndexedStack(index: _currentStep, children: [
                GymproInfoStep1(
                  onPressedNext: () {},
                ),
                GymproInfoStep2(),
                GymproInfoStep3(),
              ]),
            ),
          ),
          _buildButton(),
        ]),
      ),
    );
  }

  Widget _buildButton() {
    List<Widget> button;
    if (_currentStep == 0) {
      button = [
        SecondaryButton(
          title: '취소',
          onPressed: () {
            print('취소');
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(builder: (context) => GymproRegisterCompleted()),
            //       (Route<dynamic> route) => false,
            // );
          },
        ),
        SizedBox(width: 12.0),
        PrimaryButton(title: "다음", onPressed: _nextStep),
      ];
    } else if (_currentStep == 2) {
      button = [
        SecondaryButton(title: '이전', onPressed: _previousStep),
        SizedBox(width: 12.0),
        PrimaryButton(
          title: "가입 완료",
          onPressed: () {
            print('가입 완료');
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(builder: (context) => GymproRegisterCompleted()),
            //       (Route<dynamic> route) => false,
            // );
          },
        ),
      ];
    } else {
      button = [
        SecondaryButton(title: '이전', onPressed: _previousStep),
        SizedBox(width: 12.0),
        PrimaryButton(title: "다음", onPressed: _nextStep),
      ];
    }

    return Padding(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: button,
        ));
  }
}
