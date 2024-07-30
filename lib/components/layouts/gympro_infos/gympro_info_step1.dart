import 'package:flutter/material.dart';
import 'package:gymming_app/common/colors.dart';
import 'package:gymming_app/components/birthday_select.dart';
import 'package:gymming_app/components/input_filed.dart';
import 'package:gymming_app/components/phone_number_select.dart';
import 'package:gymming_app/components/profile_image.dart';
import 'package:gymming_app/services/utils/validate_util.dart';

class GymproInfoStep1 extends StatefulWidget {
  final Function onChanged;
  final Map<String, dynamic>? originModel;

  const GymproInfoStep1({super.key, required this.onChanged, this.originModel});

  @override
  State<StatefulWidget> createState() => GymproInfoStep1State();
}

class GymproInfoStep1State extends State<GymproInfoStep1> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _historyController = TextEditingController();
  final FocusNode _historyFocusNode = FocusNode();
  late Map<String, dynamic> _model = {
    'name': '',
    'phoneNumber': '',
    'birth': null,
    'gender': 'M',
    'history': '',
  };
  int _historyLength = 0;

  @override
  void initState() {
    super.initState();

    if (widget.originModel != null) {
      setState(() {
        _model = widget.originModel!;
        _nameController.text = _model['name'];
        _historyController.text = _model['history'];
      });
    }

    _historyController.addListener(() {
      setState(() {
        _model['history'] = _historyController.text;
        _historyLength = _historyController.text.length;
      });
      widget.onChanged(_model);
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
    });
    widget.onChanged(_model);
  }

  void onChangedBirthday(DateTime birthDay) {
    setState(() {
      _model['birth'] = birthDay;
    });
    widget.onChanged(_model);
  }

  void onChangedPhoneNumber(String phoneNumber) {
    if (ValidateUtil.isPhoneNumberValid(phoneNumber)) {
      setState(() {
        _model['phoneNumber'] = phoneNumber;
      });
      widget.onChanged(_model);
    } else {
      setState(() {
        _model['phoneNumber'] = '';
      });
      widget.onChanged(_model);
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
              originalNumber:
                  _model['phoneNumber'] == '' ? null : _model['phoneNumber'],
            ),
            SizedBox(height: 60.0),
            BirthdaySelect(
              setter: onChangedBirthday,
              originalBirthday: _model['birth'],
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
            widget.onChanged(_model);
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
            widget.onChanged(_model);
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
