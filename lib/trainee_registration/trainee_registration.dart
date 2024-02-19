import 'package:flutter/material.dart';
import 'package:gymming_app/common/colors.dart';
import 'package:gymming_app/common/component/buttons/primary_button.dart';
import 'package:gymming_app/common/component/common_header.dart';

import '../common/component/buttons/secondary_button.dart';
import '../common/constants.dart';

class TraineeRegistration extends StatefulWidget {
  const TraineeRegistration({super.key});

  @override
  _TraineeRegistration createState() => _TraineeRegistration();
}

class _TraineeRegistration extends State<TraineeRegistration> {
  final traineeNameController = TextEditingController();
  String? _firstPhoneNumber;
  String? _middlePhoneNumber;
  String? _lastPhoneNumber;
  int? _selectedYear;
  int? _selectedMonth;
  int? _selectedDay;
  int? _registeredNumber; //총 등록 횟수
  int? _finishedNumber; // 진행/차감 횟수
  List<String> _trainingDays = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _firstPhoneNumber = FIRST_PHONE_NUMBERS[0];
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    traineeNameController.dispose();
    super.dispose();
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
              CommonHeader(title: '새로운 회원 등록'),
              Text(traineeNameController.text),
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
                        controller: traineeNameController,
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
                              value: '010',
                              isDense: false,
                              iconSize: 24,
                              dropdownColor: Colors.black,
                              onChanged: (String? value) {},
                              items: const [
                                DropdownMenuItem(
                                  child: Text('010'),
                                  value: '010',
                                ),
                                DropdownMenuItem(
                                  child: Text('011'),
                                  value: '011',
                                ),
                                DropdownMenuItem(
                                  child: Text('080'),
                                  value: '080',
                                )
                              ],
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
                              decoration: InputDecoration(
                                  hintText: '1234',
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
                              decoration: InputDecoration(
                                  hintText: '1234',
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
                              onChanged: (int? value) {},
                              items: const [
                                DropdownMenuItem(
                                  child: Text('1997'),
                                  value: 1997,
                                ),
                                DropdownMenuItem(
                                  child: Text('1998'),
                                  value: 1998,
                                ),
                                DropdownMenuItem(
                                  child: Text('1999'),
                                  value: 1999,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: DropdownButtonFormField<int>(
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
                              onChanged: (int? value) {},
                              items: const [
                                DropdownMenuItem(
                                  child: Text('1월'),
                                  value: 1,
                                ),
                                DropdownMenuItem(
                                  child: Text('2월'),
                                  value: 2,
                                ),
                                DropdownMenuItem(
                                  child: Text('3월'),
                                  value: 3,
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: DropdownButtonFormField<int>(
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
                              onChanged: (int? value) {},
                              items: const [
                                DropdownMenuItem(
                                  child: Text('1일'),
                                  value: 1,
                                ),
                                DropdownMenuItem(
                                  child: Text('2일'),
                                  value: 2,
                                ),
                                DropdownMenuItem(
                                  child: Text('3일'),
                                  value: 3,
                                )
                              ],
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
                              PrimaryButton(title: "남", onPressed: () {}),
                              SizedBox(width: 12),
                              SecondaryButton(title: "여", onPressed: () {}),
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
                            SecondaryButton(title: "일", onPressed: () {}),
                            SizedBox(
                              width: 8,
                            ),
                            SecondaryButton(title: "월", onPressed: () {}),
                            SizedBox(
                              width: 8,
                            ),
                            SecondaryButton(title: "화", onPressed: () {}),
                            SizedBox(
                              width: 8,
                            ),
                            SecondaryButton(title: "수", onPressed: () {}),
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
                            SecondaryButton(title: "목", onPressed: () {}),
                            SizedBox(
                              width: 8,
                            ),
                            SecondaryButton(title: "금", onPressed: () {}),
                            SizedBox(
                              width: 8,
                            ),
                            SecondaryButton(title: "토", onPressed: () {}),
                            SizedBox(
                              width: 8,
                            ),
                            SecondaryButton(title: "불규칙", onPressed: () {}),
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
}
