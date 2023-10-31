import 'package:flutter/material.dart';
import 'package:gymming_app/common/colors.dart';
import 'package:gymming_app/user_timetable/component/calendar_modal.dart';
import 'package:gymming_app/user_timetable/component/schedule_changed.dart';
import 'package:gymming_app/user_timetable/component/time_modal.dart';

import '../../common/constants.dart';
import '../../modal/model/reason_content.dart';
import '../../modal/reason.dart';
import '../model/schedule_info.dart';

class ScheduleChange extends StatefulWidget {
  const ScheduleChange(
      {super.key, required this.originDay, required this.scheduleInfo});

  final DateTime originDay;
  final ScheduleInfo scheduleInfo;

  @override
  State<ScheduleChange> createState() => _ScheduleChangeState();
}

class _ScheduleChangeState extends State<ScheduleChange> {
  DateTime _selectedDay = DateTime.now();
  String _selectedTime = '';

  void _changeSelectedDay(DateTime selectedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _selectedTime = '';
    });
  }

  void _changeSelectedTime(String selectedTime) {
    setState(() {
      _selectedTime = selectedTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color buttonColor =
        _selectedTime.isEmpty ? PRIMARY_COLOR.withOpacity(0.3) : PRIMARY_COLOR;

    return Scaffold(
        extendBody: true,
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20),
            color: BACKGROUND_COLOR,
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Image.asset(
                          'assets/icon_nav_arrow_left.png',
                          height: 24,
                          width: 24,
                        ),
                        onPressed: () {
                          // 뒤로 가기 동작 또는 다른 작업을 수행
                          Navigator.of(context).pop();
                        },
                      ),
                      const Text('일정 변경',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(
                        width: 24,
                        height: 24,
                      ),
                    ]),
                const SizedBox(
                  height: 40,
                ),
                CalendarModal(
                  originDay: widget.originDay,
                  changeSelectedDay: _changeSelectedDay,
                ),
                const SizedBox(
                  height: 40,
                ),
                TimeModal(
                    selectedDay: _selectedDay,
                    changeSelectedTime: _changeSelectedTime),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: 350, // 원하는 가로 크기
                  height: 56, // 원하는 세로 크기
                  child: ElevatedButton(
                    onPressed:_selectedTime.isEmpty?null: () {
                      DateTime now = DateTime.now();
                      int days =
                          widget.originDay.difference( DateTime(now.year,now.month,now.day)).inDays;
                      if (days >= widget.scheduleInfo.remainDays) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScheduleChanged(
                                  beforeTime: DateTime.now(),
                                  afterTime: DateTime.now())),
                        );
                      }else{
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            Reason(
                                reasonContent: ReasonContent(
                                    changeTitle, changeSubTitle, changeReasons))
                        ));
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(buttonColor),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    child: const Text(
                      '변경 완료',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
