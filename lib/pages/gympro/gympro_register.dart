import 'package:flutter/material.dart';
import 'package:gymming_app/common/colors.dart';
import 'package:gymming_app/components/buttons/primary_button.dart';
import 'package:gymming_app/components/buttons/secondary_button.dart';
import 'package:gymming_app/components/common_header.dart';
import 'package:gymming_app/components/layouts/gympro_infos/gympro_info_step1.dart';
import 'package:gymming_app/components/layouts/gympro_infos/gympro_info_step2.dart';
import 'package:gymming_app/components/layouts/gympro_infos/gympro_info_step3.dart';
import 'package:gymming_app/pages/gympro/gympro_home/gympro_home.dart';
import 'package:gymming_app/pages/login/login_select_type.dart';
import 'package:gymming_app/pages/login/signin_success.dart';
import 'package:gymming_app/services/repositories/trainer_repository.dart';
import 'package:gymming_app/services/utils/validate_util.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../services/auth/token_manager_service.dart';
import '../../services/models/trainer_auth.dart';
import '../../services/models/trainer_details.dart';
import '../../services/repositories/auth_repository.dart';
import '../../state/info_state.dart';

class GymproRegister extends StatefulWidget {
  final String type;
  final int? trainerId;
  final String? kakaoToken;

  const GymproRegister({super.key, this.type = 'register', this.trainerId, this.kakaoToken});

  @override
  State<StatefulWidget> createState() => GymproRegisterState();
}

class GymproRegisterState extends State<GymproRegister> {
  final TrainerRepository trainerRepository =
      TrainerRepository(client: http.Client());
  final AuthRepository authRepository = AuthRepository(client: http.Client());
  String headerTitle = '';

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
    'lessonTime': 60,
    'lessonChangeRange': '',
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
    print(_model_step1);
    print("_model_step1");
    if (_model_step1['name'] == '') {
      return false;
    } else if (!ValidateUtil.isPhoneNumberValid(_model_step1['phoneNumber'])) {
      return false;
    } else if (_model_step1['birth'] == null) {
      return false;
    }
    return true;
  }

  bool _validateStep2() {
    print(_model_step2);
    if (_model_step2['lessonName'] == '') {
      return false;
    } else if (_model_step2['lessonCost'] == '') {
      return false;
    } else if (_model_step2['lessonChangeRange'] == '') {
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
  void initState() {
    super.initState();
    headerTitle = widget.type == 'register' ? '트레이너로 가입' : '트레이너 정보 수정';

    if (widget.type == 'edit') {
      _fetchData();
    }
  }

  Future<void> _fetchData() async {
    Map<String, dynamic> trainerDetail =
        await trainerRepository.getTrainerDetailReal(widget.trainerId!);

    setState(() {
      _model_step1['name'] = trainerDetail['trainer_name'];
      _model_step1['phoneNumber'] = trainerDetail['trainer_phone_number'];
      _model_step1['birth'] = trainerDetail['trainer_birthday'];
      _model_step1['gender'] = trainerDetail['trainer_gender'];
      _model_step1['history'] = trainerDetail['description'];
      _enableBtn['step1'] = true;

      _model_step2['lessonName'] = trainerDetail['lesson_name'];
      _model_step2['lessonCost'] = trainerDetail['lesson_price'];
      _model_step2['lessonTime'] = trainerDetail['lesson_minutes'];
      _model_step2['lessonTimeType'] = '매일';
      _model_step2['availableTimeList'] = trainerDetail['trainer_availability'];
      _enableBtn['step2'] = true;

      _model_step3['centerName'] = trainerDetail['center_name'];
      _model_step3['centerAddress'] = trainerDetail['center_location'];
      _model_step3['centerContact'] = trainerDetail['center_number'];
      _model_step3['centerType'] = trainerDetail['center_type'];
      _enableBtn['step3'] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          CommonHeader(
            title: headerTitle,
            onPressed: () {
              if (widget.type == 'register') {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginSelectType()),
                  (Route<dynamic> route) => false,
                );
              } else if (widget.type == 'edit') {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => GymproHome()),
                  (Route<dynamic> route) => false,
                );
              }
            },
          ),
          Expanded(
            child: IndexedStack(index: _currentStep, children: [
              SingleChildScrollView(
                child: GymproInfoStep1(
                  onChanged: onChangedStep1,
                  originModel: _model_step1,
                ),
              ),
              SingleChildScrollView(
                  child: GymproInfoStep2(
                onChanged: onChangedStep2,
                originModel: _model_step2,
              )),
              SingleChildScrollView(
                  child: GymproInfoStep3(
                onChanged: onChangedStep3,
                originModel: _model_step3,
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
            if (widget.type == 'register') {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginSelectType()),
                (Route<dynamic> route) => false,
              );
            } else if (widget.type == 'edit') {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => GymproHome()),
                (Route<dynamic> route) => false,
              );
            }
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
    } else {
      button = [
        SecondaryButton(title: '이전', onPressed: _previousStep),
        SizedBox(width: 12.0),
        PrimaryButton(
          title: "가입 완료",
          onPressed: () async {
            if (widget.type == 'register') {
              // TODO API 연결

              TrainerDetails trainerDetails = TrainerDetails.empty();
              trainerDetails.setStep1Data(_model_step1);
              trainerDetails.setStep2Data(_model_step2);
              trainerDetails.setStep3Data(_model_step3);
              print("register ---- trainer");
              print(trainerDetails.trainerAvailability);
              Map<String, Object> params = trainerDetails.toJson();
              params['kakao_token'] = widget.kakaoToken!;
              TrainerAuth trainerAuth = await authRepository.signUpTrainer(params);
              await TokenManagerService.instance.saveAccessToken(trainerAuth.accessToken);
              await TokenManagerService.instance
                  .saveRefreshToken(trainerAuth.refreshToken);
              Provider.of<InfoState>(context, listen: false).setUserId(trainerAuth.trainerId);

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => SignInSuccess(
                    type: "trainer",
                    //TODO add image url
                    imgUrl: 'assets/images/user_example.png',
                    name: _model_step1['name'],
                    birth: _model_step1['birth'],
                    gender: _model_step1['gender'],
                    phoneNumber: _model_step1['phoneNumber'],
                    additionalTitle: _model_step2['lessonName'],
                    additionalSub: _buildAdditionalSub(),
                  ),
                ),
                (Route<dynamic> route) => false,
              );
            } else if (widget.type == 'edit') {
              // TODO API 연결
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => GymproHome()),
                (Route<dynamic> route) => false,
              );
            }
          },
          enabled: _enableBtn['step3']!,
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

  List<Widget> _buildAdditionalSub() {
    var formatter = NumberFormat('#,###');
    String lessonCost = formatter.format(int.parse(_model_step2['lessonCost']));
    Widget sub1 = Row(
      children: [
        Text(
          '회당 $lessonCost원',
          style: TextStyle(color: BRIGHT_SECONDARY_COLOR, fontSize: 16.0),
        ),
        Container(
          width: 2.0,
          height: 16.0,
          color: BRIGHT_SECONDARY_COLOR,
          margin: EdgeInsets.symmetric(horizontal: 8.0),
        ),
        Text(
          '${_model_step2['lessonTime']}',
          style: TextStyle(color: BRIGHT_SECONDARY_COLOR, fontSize: 16.0),
        ),
      ],
    );
    Widget sub2 = Row(
      children: [
        Text(
          '${_model_step3['centerAddress']}',
          style: TextStyle(color: BRIGHT_SECONDARY_COLOR, fontSize: 16.0),
        ),
        Container(
          width: 2.0,
          height: 16.0,
          color: BRIGHT_SECONDARY_COLOR,
          margin: EdgeInsets.symmetric(horizontal: 8.0),
        ),
        Text(
          '${_model_step3['centerName']}',
          style: TextStyle(color: BRIGHT_SECONDARY_COLOR, fontSize: 16.0),
        ),
      ],
    );

    return [sub1, sub2];
  }
}
