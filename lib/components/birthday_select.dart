import 'package:flutter/material.dart';
import 'package:gymming_app/components/text_dropdown.dart';

import '../common/colors.dart';
import '../common/constants.dart';

class BirthdaySelect extends StatefulWidget {
  final Function setter;
  final DateTime? originalBirthday;

  const BirthdaySelect(
      {super.key, required this.setter, this.originalBirthday});

  @override
  State<StatefulWidget> createState() => _BirthdaySelectState();
}

class _BirthdaySelectState extends State<BirthdaySelect> {
  int? _selectedYear;
  int? _selectedMonth;
  int? _selectedDay;
  final List<String> _yearList = [];
  List<String> _dayList = [];
  final int startYear = DateTime.now().year - 50;
  final int endYear = DateTime.now().year;

  void getYear(String result) {
    _selectedYear = int.parse(result);
    setState(() {
      _dayList = getDays(_selectedYear, _selectedMonth);
    });
    setBirthday();
  }

  void getMonth(String result) {
    _selectedMonth = int.parse(result);
    setState(() {
      _dayList = getDays(_selectedYear, _selectedMonth);
    });
    setBirthday();
  }

  void getDay(String result) {
    _selectedDay = int.parse(result);
    setBirthday();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.originalBirthday != null) {
      _selectedYear = widget.originalBirthday!.year;
      _selectedMonth = widget.originalBirthday!.month;
      _selectedDay = widget.originalBirthday!.day;
    }
    for (int i = startYear; i <= endYear; i++) {
      _yearList.add(i.toString());
    }
    _dayList = getDays(_selectedYear, _selectedMonth);
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
                  '생년월일',
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
          children: [
            TextDropdown(
              placeholder: '출생년도',
              dropdownItems: _yearList,
              setter: getYear,
              dropdownWidth: 140.0,
              originValue:
                  _selectedYear != null ? _selectedYear.toString() : '',
            ),
            SizedBox(
              width: 12,
            ),
            TextDropdown(
              placeholder: '월',
              dropdownItems: MONTHS,
              setter: getMonth,
              dropdownWidth: 93.0,
              originValue: _selectedMonth != null
                  ? getValueWithZero(_selectedMonth!)
                  : '',
            ),
            SizedBox(
              width: 12,
            ),
            TextDropdown(
              placeholder: '일',
              dropdownItems: _dayList,
              setter: getDay,
              dropdownWidth: 93.0,
              originValue:
                  _selectedDay != null ? getValueWithZero(_selectedDay!) : '',
            ),
          ],
        ),
      ],
    );
  }

  String getValueWithZero(int value) {
    if (value < 10) {
      return "0$value";
    }
    return value.toString();
  }

  List<String> getDays(int? selectedYear, int? selectedMonth) {
    selectedMonth ??= 1;
    selectedYear ??= DateTime.now().year;
    int days = DateUtils.getDaysInMonth(selectedYear, selectedMonth);
    days++;
    List<String> result = [];
    for (int i = 1; i < days; i++) {
      if (i < 10) {
        result.add("0$i");
      } else {
        result.add(i.toString());
      }
    }
    return result;
  }

  void setBirthday() {
    try {
      widget.setter(DateTime(_selectedYear!, _selectedMonth!, _selectedDay!));
    } catch (e) {
      return;
    }
  }
}
