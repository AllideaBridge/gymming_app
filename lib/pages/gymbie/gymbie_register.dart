import 'package:flutter/material.dart';
import 'package:gymming_app/components/birthday_select.dart';
import 'package:gymming_app/components/common_header.dart';
import 'package:gymming_app/components/input_filed.dart';
import 'package:gymming_app/components/phone_number_select.dart';
import 'package:gymming_app/components/profile_image.dart';

import '../../common/colors.dart';
import '../login/signin_succeed.dart';

class GymbieRegister extends StatefulWidget {
  @override
  State<GymbieRegister> createState() => _GymbieRegisterState();
}

class _GymbieRegisterState extends State<GymbieRegister> {
  final TextEditingController _nameController = TextEditingController();
  bool _isUserSignUpValidate = false;
  bool _isNameValidate = false;
  String _phoneNumber = '';
  bool _isPhoneNumberValidate = false;
  late DateTime _birthday;
  bool _isBirthdayValidate = false;
  String _gender = "M";

  void validateUserSignUp() {
    setState(() {
      _isUserSignUpValidate =
          _isNameValidate && _isPhoneNumberValidate && _isBirthdayValidate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: SafeArea(
        child: Column(
          children: [
            CommonHeader(title: '회원으로 가입'),
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        ProfileImage(size: 130),
                        SizedBox(
                          height: 60,
                        ),
                        InputField(
                            controller: _nameController,
                            title: "이름",
                            isRequired: true,
                            onValidationChanged: (value) {
                              setState(() {
                                _isNameValidate = value;
                              });
                              validateUserSignUp();
                            }),
                        SizedBox(
                          height: 60,
                        ),
                        PhoneNumberSelect(
                            title: "전화번호",
                            setter: (String value) {
                              setState(() {
                                _isPhoneNumberValidate = value.length == 11;
                                _phoneNumber = value;
                              });
                              validateUserSignUp();
                            }),
                        SizedBox(
                          height: 60,
                        ),
                        BirthdaySelect(setter: (selectedDate) {
                          setState(() {
                            _birthday = selectedDate;
                            _isBirthdayValidate = true;
                          });
                          validateUserSignUp();
                        }),
                        SizedBox(
                          height: 60,
                        ),
                        _buildGenderSelect()
                      ],
                    ),
                  ],
                ),
              ),
            )),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
              child: ElevatedButton(
                  onPressed: () {
                    if (!_isUserSignUpValidate) {
                      return;
                    }

                    signInUser();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignInSucceed(
                                type: "user",
                                imgUrl: 'assets/images/user_example.png',
                                //todo add image url
                                name: _nameController.text,
                                birth: _birthday,
                                gender: _gender,
                                phoneNumber: _phoneNumber,
                              )),
                      (Route<dynamic> route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR
                        .withOpacity(_isUserSignUpValidate ? 1.0 : 0.5),
                    minimumSize: const Size.fromHeight(52),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  child: Text('가입 완료',
                      style: TextStyle(
                        color: INDICATOR_COLOR,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ))),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderSelect() {
    bool isSelectedMale = true;

    if (_gender == 'M') {
      isSelectedMale = true;
    } else {
      isSelectedMale = false;
    }

    return Row(
      children: [
        Expanded(
            child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: isSelectedMale ? PRIMARY_COLOR : BTN_COLOR,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              minimumSize: Size(160, 56)),
          onPressed: () {
            setState(() {
              _gender = 'M';
            });
          },
          child: Text(
            '남',
            style: TextStyle(
              color: isSelectedMale ? INDICATOR_COLOR : Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        )),
        SizedBox(width: 8.0),
        Expanded(
            child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: isSelectedMale ? BTN_COLOR : PRIMARY_COLOR,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              minimumSize: Size(160, 56)),
          onPressed: () {
            setState(() {
              _gender = 'F';
            });
          },
          child: Text(
            '여',
            style: TextStyle(
              color: isSelectedMale ? Colors.white : INDICATOR_COLOR,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        )),
      ],
    );
  }

  void signInUser() {
    Map<String, Object> params = <String, Object>{};
    params['user_name'] = _nameController.text;
    params['phone_number'] = _phoneNumber;
    params["gender"] = _gender;
    params["birth"] = _birthday;
    //api 추가
    print(params);
  }
}
