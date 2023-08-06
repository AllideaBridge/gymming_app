import 'package:flutter/material.dart';

class ScheduleDisplay extends StatelessWidget {
  final DateTime time;
  final String lesson;
  final bool isToday;
  final int idx;

  const ScheduleDisplay(
      {Key? key,
      required this.time,
      required this.lesson,
      required this.isToday,
      required this.idx})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int hour = time.hour;
    int minute = time.minute;

    return Container(
      width: 50,
      height: 50,
      margin: EdgeInsets.only(top: 20),
      color: isToday ? Color(0xffCDFB60) : Color(0x7fCDFB60),
      child: Column(
        children: [
          Text('$hour:$minute'),
          Text(lesson),
        ],
      ),
    );
  }
}
