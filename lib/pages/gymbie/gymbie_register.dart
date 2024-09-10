import 'package:flutter/material.dart';
import 'package:gymming_app/components/birthday_select.dart';
import 'package:gymming_app/components/common_header.dart';
import 'package:gymming_app/components/input_filed.dart';
import 'package:gymming_app/components/phone_number_select.dart';
import 'package:gymming_app/components/profile_image.dart';
import 'package:gymming_app/pages/gymbie/gymbie_home/gymbie_home.dart';
import 'package:gymming_app/services/repositories/user_repository.dart';
import 'package:gymming_app/services/utils/validate_util.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../common/colors.dart';
import '../../services/models/user_auth.dart';
import '../../services/models/user_detail.dart';
import '../login/signin_success.dart';

class GymbieRegister extends StatefulWidget {
  final String type;
  final int? userId;
  final UserAuth? userAuth;

  const GymbieRegister(
      {super.key, this.type = 'register', this.userId, required this.userAuth});

  @override
  State<GymbieRegister> createState() => _GymbieRegisterState();
}

class _GymbieRegisterState extends State<GymbieRegister> {
  final UserRepository userRepository = UserRepository(client: http.Client());
  final TextEditingController _nameController = TextEditingController();

  String headerTitle = '';

  bool _isUserSignUpValidate = false;
  bool _isNameValidate = false;
  String? _phoneNumber;
  bool _isPhoneNumberValidate = false;
  DateTime? _birthday;
  bool _isBirthdayValidate = false;
  String _gender = "M";
  XFile? _profileImage;

  void validateUserSignUp() {
    setState(() {
      _isUserSignUpValidate =
          _isNameValidate && _isPhoneNumberValidate && _isBirthdayValidate;
    });
  }

  Future<XFile> urlToXFile(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return XFile.fromData(
        response.bodyBytes,
        mimeType: response.headers['content-type'],
        name: 'tempfile', // 파일 이름 설정
      );
    } else {
      throw Exception('Failed to download file');
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.type == 'edit') {
      _fetchData();
    }

    headerTitle = widget.type == 'register' ? '회원으로 가입' : '회원정보 수정';
  }

  void _fetchData() async {
    Map<String, dynamic> userDetail =
    await userRepository.getUserDetail(widget.userId!);
    XFile profileImg = await urlToXFile(userDetail['user_profile_img_url']);
    setState(() {
      _nameController.text = userDetail['user_name'];
      _phoneNumber = userDetail['user_phone_number'];
      _birthday = userDetail['user_birthday'];
      _gender = userDetail['user_gender'];

      _profileImage = profileImg;
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
            CommonHeader(title: headerTitle),
            Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            ProfileImage(
                              size: 130,
                              originImgUrl: _profileImage,
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            InputField(
                                controller: _nameController,
                                title: "이름",
                                isRequired: true,
                                validator: (val) {
                                  if (val.length < 1) return '이름은 필수값입니다.';
                                },
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
                                  _isPhoneNumberValidate =
                                      ValidateUtil.isPhoneNumberValid(value);
                                  _phoneNumber = value;
                                });
                                validateUserSignUp();
                              },
                              originalNumber: _phoneNumber,
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            BirthdaySelect(
                              setter: (selectedDate) {
                                setState(() {
                                  _birthday = selectedDate;
                                  _isBirthdayValidate = true;
                                });
                                validateUserSignUp();
                              },
                              originalBirthday: _birthday,
                            ),
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
                    onClickConfirmButton();
                    if (widget.type == 'register') {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SignInSuccess(
                                  type: "user",
                                  imgUrl: 'assets/images/user_example.png',
                                  //todo add image url
                                  name: _nameController.text,
                                  birth: _birthday!,
                                  gender: _gender,
                                  phoneNumber: _phoneNumber!,
                                )),
                            (Route<dynamic> route) => false,
                      );
                    } else if (widget.type == 'edit') {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => GymbieHome()),
                            (Route<dynamic> route) => false,
                      );
                    }
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

  void onClickConfirmButton() async {
    // UserDetail userInfo= UserDetail()
    Map<String, Object> params = <String, Object>{};
    params['user_name'] = _nameController.text;
    params['phone_number'] = _phoneNumber!;
    params["gender"] = _gender;
    params["birth"] = _birthday!;
    if (widget.type == 'register') {
      // TODO API 연결
      print('새로운 회원 등록');
      // userRepository.updateUser(userInfo)
    } else if (widget.type == 'edit') {
      // TODO API 연결
      print('회원 정보 수정');
    }
  }
}
