import 'package:flutter/material.dart';
import 'package:gymming_app/common/colors.dart';
import 'package:gymming_app/common/component/buttons/primary_button.dart';
import 'package:gymming_app/common/component/common_header.dart';

import '../models/trainee_detail.dart';
import '../trainer_timetable/trainer_timetable.dart';

class TraineeInput extends StatefulWidget {
  final bool isRegister;
  TraineeDetail? traineeDetail;

  TraineeInput({super.key, required this.isRegister, this.traineeDetail});

  @override
  _TraineeInput createState() => _TraineeInput();
}

class _TraineeInput extends State<TraineeInput> {
  late TextEditingController _nameController;
  late TextEditingController _middlePhoneNumberController;
  late TextEditingController _lastPhoneNumberController;
  late TextEditingController _totalDayController;
  late TextEditingController _usedDayController;
  late TextEditingController _specificDetailsController;
  late String _selectedFirstPhoneNumber;
  int? _selectedYear;
  int? _selectedMonth;
  int? _selectedDay;
  bool _isMaleSelected = true;
  bool _isWorkdayIrregular = false;
  List<bool> _availableWorkdays = List.generate(7, (index) => false);

  final firstPhoneNumbers = ['010', '011', '080'];
  final years = [1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002];
  final months = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
  final days = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];

  @override
  void initState() {
    super.initState();
    if (widget.isRegister == false && widget.traineeDetail != null) {
      _selectedFirstPhoneNumber = widget.traineeDetail!.phoneNumber;
      _selectedYear = int.parse(widget.traineeDetail!.birth.split(".")[0]);
      _selectedMonth = int.parse(widget.traineeDetail!.birth.split(".")[1]);
      _selectedDay = int.parse(widget.traineeDetail!.birth.split(".")[2]);
      _isMaleSelected = widget.traineeDetail!.gender == '남';
    }

    _nameController = TextEditingController(
        text: !widget.isRegister ? widget.traineeDetail!.name : null);
    _middlePhoneNumberController = TextEditingController(
        text: !widget.isRegister
            ? widget.traineeDetail!.phoneNumber.split("-")[1]
            : null);
    _lastPhoneNumberController = TextEditingController(
        text: !widget.isRegister
            ? widget.traineeDetail!.phoneNumber.split("-")[2]
            : null);
    _totalDayController = TextEditingController(
        text: !widget.isRegister
            ? widget.traineeDetail!.totalDay.toString()
            : null);
    _usedDayController = TextEditingController(
        text: !widget.isRegister
            ? widget.traineeDetail!.usedDay.toString()
            : null);
    _specificDetailsController = TextEditingController(
        text: !widget.isRegister ? widget.traineeDetail!.specificDetail : null);

    setState(() {
      _selectedFirstPhoneNumber = firstPhoneNumbers[0];
    });
  }

  void clickSexSelectButton() {
    setState(() {
      _isMaleSelected = !_isMaleSelected;
    });
  }

  void clickAvailableWorkday(int index) {
    setState(() {
      if (_availableWorkdays[index] == false) {
        _isWorkdayIrregular = false;
      }
      _availableWorkdays[index] = !_availableWorkdays[index];
    });
  }

  void clickIrregularWorkday() {
    setState(() {
      if (_isWorkdayIrregular == false) {
        _availableWorkdays = List.generate(7, (index) => false);
      }
      _isWorkdayIrregular = !_isWorkdayIrregular;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
            body: SafeArea(
                child: SingleChildScrollView(
          child: Column(
            children: [
              CommonHeader(
                  title: widget.isRegister ? '새로운 회원 등록' : '회원 정보 수정',
                  onPressed: () {
                    widget.isRegister
                        ? Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TrainerTimeTable()),
                            (route) => false,
                          )
                        : Navigator.pop(context);
                  }),
              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      inputFieldTitle('회원 이름', true),
                      TextField(
                        decoration: InputDecoration(
                            hintText: 'ex) 김운동',
                            hintStyle: TextStyle(color: TERITARY_COLOR),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: SECONDARY_COLOR,
                              width: 2.0,
                            )),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: PRIMARY_COLOR, width: 2.0)),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 11, horizontal: 8)),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                        controller: _nameController,
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      inputFieldTitle('연락처', true),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 92,
                            height: 52,
                            child: DropdownButtonFormField<String>(
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                              decoration: InputDecoration(
                                enabled: true,
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: SECONDARY_COLOR, width: 2.0)),
                                contentPadding:
                                    EdgeInsets.fromLTRB(8, 0, 16, 0),
                              ),
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.white,
                              ),
                              itemHeight: 52,
                              value: _selectedFirstPhoneNumber,
                              isDense: false,
                              iconSize: 24,
                              dropdownColor: Colors.black,
                              items: firstPhoneNumbers
                                  .map((e) => DropdownMenuItem(
                                      value: e, child: Text(e)))
                                  .toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedFirstPhoneNumber = value!;
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 12),
                          Container(
                            width: 8,
                            height: 2,
                            color: SECONDARY_COLOR,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              decoration: phoneNumberInputDecoration('1234'),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                              keyboardType: TextInputType.phone,
                              maxLength: 4,
                              controller: _middlePhoneNumberController,
                            ),
                          ),
                          SizedBox(width: 12),
                          Container(
                            width: 8,
                            height: 2,
                            color: SECONDARY_COLOR,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              decoration: phoneNumberInputDecoration('1234'),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                              keyboardType: TextInputType.phone,
                              maxLength: 4,
                              controller: _lastPhoneNumberController,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      inputFieldTitle('나이', true),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 140,
                            height: 52,
                            child: DropdownButtonFormField<int>(
                              value: _selectedYear,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                              decoration: InputDecoration(
                                enabled: true,
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: SECONDARY_COLOR, width: 2.0)),
                                contentPadding:
                                    EdgeInsets.fromLTRB(8, 0, 16, 0),
                              ),
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.white,
                              ),
                              hint: Text(
                                '출생연도',
                                style: TextStyle(color: TERITARY_COLOR),
                              ),
                              itemHeight: 52,
                              isDense: false,
                              iconSize: 24,
                              dropdownColor: Colors.black,
                              items: years
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e.toString()),
                                      ))
                                  .toList(),
                              onChanged: (int? value) {
                                setState(() {
                                  _selectedYear = value!;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              value: _selectedMonth,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                              decoration: InputDecoration(
                                enabled: true,
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: SECONDARY_COLOR, width: 2.0)),
                                contentPadding:
                                    EdgeInsets.fromLTRB(8, 0, 16, 0),
                              ),
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.white,
                              ),
                              itemHeight: 52,
                              hint: Text(
                                '월',
                                style: TextStyle(color: TERITARY_COLOR),
                              ),
                              isDense: false,
                              iconSize: 24,
                              dropdownColor: Colors.black,
                              items: months
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e.toString()),
                                      ))
                                  .toList(),
                              onChanged: (int? value) {
                                setState(() {
                                  _selectedMonth = value!;
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              value: _selectedDay,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                              decoration: InputDecoration(
                                enabled: true,
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: SECONDARY_COLOR, width: 2.0)),
                                contentPadding:
                                    EdgeInsets.fromLTRB(8, 0, 16, 0),
                              ),
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.white,
                              ),
                              itemHeight: 52,
                              hint: Text(
                                '일',
                                style: TextStyle(color: TERITARY_COLOR),
                              ),
                              isDense: false,
                              iconSize: 24,
                              dropdownColor: Colors.black,
                              items: days
                                  .map((e) => DropdownMenuItem(
                                      value: e, child: Text(e.toString())))
                                  .toList(),
                              onChanged: (int? value) {
                                setState(() {
                                  _selectedDay = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      inputFieldTitle('성별', true),
                      SizedBox(
                          height: 56,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              getSwitchButton('남', _isMaleSelected),
                              SizedBox(width: 12),
                              getSwitchButton('여', !_isMaleSelected),
                            ],
                          )),
                      SizedBox(
                        height: 60,
                      ),
                      inputFieldTitle('등록 횟수', true),
                      TextField(
                        decoration: InputDecoration(
                            hintText: '숫자만 입력 가능',
                            hintStyle: TextStyle(color: TERITARY_COLOR),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: SECONDARY_COLOR,
                              width: 2.0,
                            )),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 8)),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                        keyboardType: TextInputType.number,
                        controller: _totalDayController,
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      inputFieldTitle('진행/차감 횟수', true),
                      TextField(
                        decoration: InputDecoration(
                            hintText: '0',
                            hintStyle: TextStyle(color: TERITARY_COLOR),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: SECONDARY_COLOR,
                              width: 2.0,
                            )),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 8)),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                        keyboardType: TextInputType.number,
                        controller: _usedDayController,
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      inputFieldTitle('운동일', true),
                      SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: 260,
                        child: Text(
                          '‘불규칙’은 회원이 일정 기간 동안 등록 회수에서 차감하여 직접 예약하는 방식입니다.',
                          style:
                              TextStyle(fontSize: 14, color: SECONDARY_COLOR),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 44,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            getMultiSelectableButton(
                                "일", _availableWorkdays[0], 0),
                            SizedBox(
                              width: 8,
                            ),
                            getMultiSelectableButton(
                                "월", _availableWorkdays[1], 1),
                            SizedBox(
                              width: 8,
                            ),
                            getMultiSelectableButton(
                                "화", _availableWorkdays[2], 2),
                            SizedBox(
                              width: 8,
                            ),
                            getMultiSelectableButton(
                                "수", _availableWorkdays[3], 3),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: 44,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            getMultiSelectableButton(
                                "목", _availableWorkdays[4], 4),
                            SizedBox(
                              width: 8,
                            ),
                            getMultiSelectableButton(
                                "금", _availableWorkdays[5], 5),
                            SizedBox(
                              width: 8,
                            ),
                            getMultiSelectableButton(
                                "토", _availableWorkdays[6], 6),
                            SizedBox(
                              width: 8,
                            ),
                            getMultiSelectableButton(
                                "불규칙", _isWorkdayIrregular, 7,
                                isIrregularButton: true),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      inputFieldTitle('특이사항', false),
                      TextField(
                        decoration: InputDecoration(
                            hintText: 'ex) 평일 14시까지 통화 어려움',
                            hintStyle: TextStyle(color: TERITARY_COLOR),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: SECONDARY_COLOR,
                              width: 2.0,
                            )),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 8)),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                        controller: _specificDetailsController,
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      SizedBox(
                          height: 56,
                          child: Row(
                            children: [
                              PrimaryButton(
                                  title: '새로운 회원 등록', onPressed: () {}),
                            ],
                          ))
                    ],
                  ))
            ],
          ),
        ))));
  }

  Widget inputFieldTitle(String title, bool required) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              required ? '*' : '',
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
    );
  }

  //성별 선택 용 switch
  Widget getSwitchButton(String title, bool isSelected) {
    return Expanded(
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: isSelected ? PRIMARY_COLOR : BTN_COLOR,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                minimumSize: Size(50, 56)),
            onPressed: () {
              clickSexSelectButton();
            },
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? INDICATOR_COLOR : Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            )));
  }

  // 요일 다중 선택 용 버튼
  Widget getMultiSelectableButton(String title, bool isSelected, int index,
      {bool isIrregularButton = false}) {
    return Expanded(
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: isSelected ? PRIMARY_COLOR : BTN_COLOR,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                minimumSize: Size(50, 44)),
            onPressed: () {
              if (isIrregularButton) {
                clickIrregularWorkday();
              } else {
                clickAvailableWorkday(index);
              }
            },
            child: Text(
              title,
              softWrap: false,
              style: TextStyle(
                color: isSelected ? INDICATOR_COLOR : Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            )));
  }

  InputDecoration phoneNumberInputDecoration(String hintText) {
    return InputDecoration(
        counterText: '',
        hintText: hintText,
        hintStyle: TextStyle(color: TERITARY_COLOR),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: SECONDARY_COLOR,
          width: 2.0,
        )),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
        contentPadding: EdgeInsets.symmetric(vertical: 11, horizontal: 8));
  }
}
