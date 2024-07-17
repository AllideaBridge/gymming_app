import 'package:flutter/material.dart';
import 'package:gymming_app/components/text_dropdown.dart';

import '../common/colors.dart';
import '../common/constants.dart';

class PhoneNumberSelect extends StatefulWidget {
  const PhoneNumberSelect(
      {super.key,
      required this.title,
      required this.setter,
      this.originalNumber});

  final String title;

  /*  문자열 결과를 받는 메소드
  XXXXXXXXXXX 형태로 결과 전송됨
  중간 번호 값이 비어있더라도 전송되기 때문에 최종적으로 문자열 길이 확인 필요
  */
  final Function setter;

  final String? originalNumber;

  @override
  State<StatefulWidget> createState() => _PhoneNumberSelectState();
}

class _PhoneNumberSelectState extends State<PhoneNumberSelect> {
  final FocusNode _middleFocusNode = FocusNode();
  final FocusNode _endFocusNode = FocusNode();

  //초기값 설정을 위한 controller
  final TextEditingController _middleNumberController = TextEditingController();
  final TextEditingController _endNumberController = TextEditingController();
  String _firstNumber = "";
  String _middleNumber = "";
  String _endNumber = "";

  //textfield validate value
  bool _middleNumberValidate = true;
  bool _endNumberValidate = true;

  @override
  void initState() {
    super.initState();
    if (widget.originalNumber != null) {
      _firstNumber = widget.originalNumber!.split("-")[0];
      _middleNumber = widget.originalNumber!.split("-")[1];
      _endNumber = widget.originalNumber!.split("-")[2];
      _middleNumberController.text = widget.originalNumber!.split("-")[1];
      _endNumberController.text = widget.originalNumber!.split("-")[2];
    }
  }

  @override
  void dispose() {
    _middleFocusNode.dispose();
    _endFocusNode.dispose();
    super.dispose();
  }

  void getFirstNumbers(String result) {
    _firstNumber = result;
    widget.setter("$_firstNumber$_middleNumber$_endNumber");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Row(
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  '*',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: PRIMARY2_COLOR),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextDropdown(
              placeholder: '010',
              dropdownItems: FIRST_NUMBERS,
              setter: getFirstNumbers,
              dropdownWidth: 100.0,
              originValue: _firstNumber,
            ),
            SizedBox(width: 12),
            Container(
              width: 8,
              height: 2,
              color: SECONDARY_COLOR,
              margin: EdgeInsets.only(top: 25),
            ),
            SizedBox(width: 12),
            SizedBox(
              width: 97,
              child: TextField(
                focusNode: _middleFocusNode,
                controller: _middleNumberController,
                onChanged: (String value) {
                  setState(() {
                    _middleNumber = value;
                    widget.setter("$_firstNumber$_middleNumber$_endNumber");
                  });
                },
                onTapOutside: (event) {
                  setState(() {
                    _middleNumberValidate = (_middleNumber.length == 4);
                  });
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                style: TextStyle(color: Colors.white, fontSize: 20),
                keyboardType: TextInputType.phone,
                decoration:
                    buildPhoneNumberInputDecoration(validateMiddleNumberText),
                maxLength: 4,
              ),
            ),
            SizedBox(width: 12),
            Container(
              width: 8,
              height: 2,
              color: SECONDARY_COLOR,
              margin: EdgeInsets.only(top: 25),
            ),
            SizedBox(width: 12),
            SizedBox(
              width: 97,
              child: TextField(
                focusNode: _endFocusNode,
                controller: _endNumberController,
                onChanged: (String value) {
                  setState(() {
                    _endNumber = value;
                    widget.setter("$_firstNumber$_middleNumber$_endNumber");
                  });
                },
                onTapOutside: (event) {
                  setState(() {
                    _endNumberValidate = (_endNumber.length == 4);
                  });
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                style: TextStyle(color: Colors.white, fontSize: 20),
                keyboardType: TextInputType.phone,
                decoration:
                    buildPhoneNumberInputDecoration(validateEndNumberText),
                maxLength: 4,
              ),
            ),
          ],
        ),
      ],
    );
  }

  InputDecoration buildPhoneNumberInputDecoration(Function validateFunction) {
    return InputDecoration(
      hintText: "1234",
      hintStyle: TextStyle(color: TERITARY_COLOR, fontSize: 20),
      counterText: '',
      errorText: validateFunction(),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red[700]!,
          width: 2.0,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: SECONDARY_COLOR,
          width: 2.0,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: PRIMARY_COLOR,
          width: 2.0,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        vertical: 11,
        horizontal: 8,
      ),
    );
  }

  String? validateMiddleNumberText() =>
      _middleNumberValidate ? null : '올바른 형식으로 입력하세요';

  String? validateEndNumberText() =>
      _endNumberValidate ? null : '올바른 형식으로 입력하세요';
}
