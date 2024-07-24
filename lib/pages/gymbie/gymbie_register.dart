import 'package:flutter/material.dart';
import 'package:gymming_app/components/birthday_select.dart';
import 'package:gymming_app/components/common_header.dart';
import 'package:gymming_app/components/input_filed.dart';
import 'package:gymming_app/components/phone_number_select.dart';
import 'package:gymming_app/components/profile_image.dart';

import '../../common/colors.dart';

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
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              CommonHeader(title: '회원으로 가입'),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
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
                        })
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {},
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
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
