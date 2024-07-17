import 'package:flutter/material.dart';
import 'package:gymming_app/common/colors.dart';
import 'package:gymming_app/components/birthday_select.dart';
import 'package:gymming_app/components/input_filed.dart';
import 'package:gymming_app/components/phone_number_select.dart';
import 'package:gymming_app/components/profile_image.dart';

class GymproInfoStep1 extends StatefulWidget {
  final Function onPressedNext;

  const GymproInfoStep1({super.key, required this.onPressedNext});

  @override
  State<StatefulWidget> createState() => GymproInfoStep1State();
}

class GymproInfoStep1State extends State<GymproInfoStep1> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _historyController = TextEditingController();
  final FocusNode _historyFocusNode = FocusNode();
  final Map<String, dynamic> _model = {
    'name': '',
    'phoneNumber': '',
    'birth': DateTime.now(),
    'gender': 'M',
    'history': '',
  };
  final Map<String, bool> _validate = {
    'name': false,
    'phoneNumber': false,
    'birth': false,
  };
  int _historyLength = 0;

  @override
  void initState() {
    super.initState();

    _historyController.addListener(() {
      setState(() {
        _model['history'] = _historyController.text;
        _historyLength = _historyController.text.length;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _historyController.dispose();
    _historyFocusNode.dispose();
    super.dispose();
  }

  void onChangedName(bool isValid) {
    setState(() {
      _model['name'] = _nameController.text;
      _validate['name'] = isValid;
    });
  }

  void onChangedBirthday(DateTime birthDay) {
    setState(() {
      _model['birth'] = birthDay;
      _validate['birth'] = true;
    });
  }

  void onChangedPhoneNumber(String phoneNumber) {
    if (phoneNumber.length == 11) {
      setState(() {
        _model['phoneNumber'] = phoneNumber;
        _validate['phoneNumber'] = true;
      });
    } else {
      setState(() {
        _model['phoneNumber'] = '';
        _validate['phoneNumber'] = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ProfileImage(
              size: 130.0,
            ),
            SizedBox(height: 60.0),
            InputField(
              controller: _nameController,
              title: '이름',
              validator: (val) {
                if (val.length < 1) return '이름은 필수값입니다.';
              },
              onValidationChanged: onChangedName,
              isRequired: true,
            ),
            SizedBox(height: 60.0),
            PhoneNumberSelect(
              title: '전화번호',
              setter: onChangedPhoneNumber,
              // middleFocusNode: _phoneMiddleFocusNode,
              // endFocusNode: _phoneEndFocusNode,
            ),
            SizedBox(height: 60.0),
            BirthdaySelect(
              setter: onChangedBirthday,
            ),
            SizedBox(height: 60.0),
            _buildGenderSelect(),
            SizedBox(height: 60.0),
            _buildHistoryField(),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderSelect() {
    bool isSelectedMale = true;

    if (_model['gender'] == 'M') {
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
              _model['gender'] = 'M';
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
              _model['gender'] = 'F';
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

  Widget _buildHistoryField() {
    return SizedBox(
      height: 180,
      child: Stack(
        children: [
          TextField(
            controller: _historyController,
            focusNode: _historyFocusNode,
            maxLines: 50,
            decoration: InputDecoration(
              hintText: '트레이너 이력을 입력해주세요.',
              hintStyle: TextStyle(fontSize: 18, color: TERITARY_COLOR),
              filled: true,
              fillColor: BACKGROUND_COLOR,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
            style: TextStyle(fontSize: 18, color: Colors.white),
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
          Positioned(
            right: 16,
            bottom: 12,
            child: Text(
              '$_historyLength / 255',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
