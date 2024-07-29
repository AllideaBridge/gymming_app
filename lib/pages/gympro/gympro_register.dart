import 'package:flutter/material.dart';
import 'package:gymming_app/components/buttons/primary_button.dart';
import 'package:gymming_app/components/buttons/secondary_button.dart';
import 'package:gymming_app/components/common_header.dart';
import 'package:gymming_app/components/layouts/gympro_infos/gympro_info_step1.dart';
import 'package:gymming_app/components/layouts/gympro_infos/gympro_info_step2.dart';
import 'package:gymming_app/components/layouts/gympro_infos/gympro_info_step3.dart';

class GymproRegister extends StatefulWidget {
  const GymproRegister({super.key});

  @override
  State<StatefulWidget> createState() => GymproRegisterState();
}

class GymproRegisterState extends State<GymproRegister> {
  late Map<String, dynamic> _model_step1 = <String, dynamic>{
    'name': '',
    'phoneNumber': '',
    'birth': null,
    'gender': 'M',
    'history': '',
  };
  late Map<String, dynamic> _model_step2 = <String, dynamic>{
    'lessonName': '',
    'lessonCost': '',
    'lessonTime': null,
    'lessonTimeType': null,
    'availableTimeList': [],
  };
  late Map<String, dynamic> _model_step3 = <String, dynamic>{
    'centerName': '',
    'centerAddress': '',
    'centerContact': '',
    'centerType': '',
  };
  final Map<String, bool> _enableBtn = {
    'step1': false,
    'step2': false,
    'step3': false,
  };

  int _currentStep = 0;

  void onChangedStep1(Map<String, dynamic> model) {
    setState(() {
      _model_step1 = model;
      _enableBtn['step1'] = _validateStep1();
    });
  }

  void onChangedStep2(Map<String, dynamic> model) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _model_step2 = model;
        _enableBtn['step2'] = _validateStep2();
      });
    });
  }

  void onChangedStep3(Map<String, dynamic> model) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _model_step3 = model;
        _enableBtn['step3'] = _validateStep3();
      });
    });
  }

  void _nextStep() {
    setState(() {
      if (_currentStep < 3) {
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

  bool _validateStep1() {
    if (_model_step1['name'] == '') {
      return false;
    } else if (_model_step1['phoneNumber'].length < 11) {
      return false;
    } else if (_model_step1['birth'] == null) {
      return false;
    }
    return true;
  }

  bool _validateStep2() {
    if (_model_step2['lessonName'] == '') {
      return false;
    } else if (_model_step2['lessonCost'] == '') {
      return false;
    } else if (_model_step2['lessonTime'] == null) {
      return false;
    } else if (_model_step2['lessonTimeType'] == null) {
      return false;
    } else if (_model_step2['availableTimeList'] == []) {
      return false;
    } else if (!_validateAvailableTime()) {
      return false;
    }
    return true;
  }

  bool _validateStep3() {
    print(_model_step3);
    if (_model_step3['centerName'] == '') {
      return false;
    } else if (_model_step3['centerAddress'] == '') {
      return false;
    } else if (_model_step3['centerContact'] == '') {
      return false;
    } else if (_model_step3['centerType'] == '') {
      return false;
    }
    return true;
  }

  bool _validateAvailableTime() {
    for (Map<String, dynamic> item in _model_step2['availableTimeList']) {
      if (item['isChecked']) {
        if (item['start'].length < 5 || item['end'].length < 5) {
          return false;
        }
      }
    }
    return true;
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
            child: IndexedStack(index: _currentStep, children: [
              SingleChildScrollView(
                child: GymproInfoStep1(
                  onChanged: onChangedStep1,
                ),
              ),
              SingleChildScrollView(
                  child: GymproInfoStep2(
                onChanged: onChangedStep2,
              )),
              SingleChildScrollView(
                  child: GymproInfoStep3(
                onChanged: onChangedStep3,
              )),
            ]),
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
        PrimaryButton(
            title: "다음", onPressed: _nextStep, enabled: _enableBtn['step1']!),
      ];
    } else if (_currentStep == 1) {
      button = [
        SecondaryButton(title: '이전', onPressed: _previousStep),
        SizedBox(width: 12.0),
        PrimaryButton(
            title: "다음", onPressed: _nextStep, enabled: _enableBtn['step2']!),
      ];
    } else if (_currentStep == 2) {
      button = [
        SecondaryButton(title: '이전', onPressed: _previousStep),
        SizedBox(width: 12.0),
        PrimaryButton(
            title: "다음", onPressed: _nextStep, enabled: _enableBtn['step3']!),
      ];
    } else {
      button = [
        SecondaryButton(title: '이전', onPressed: _previousStep),
        SizedBox(width: 12.0),
        PrimaryButton(
          title: "가입 완료",
          onPressed: () {
            print('가입 완료: $_model_step1');
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(builder: (context) => GymproRegisterCompleted()),
            //       (Route<dynamic> route) => false,
            // );
          },
        ),
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
