import 'package:flutter/material.dart';
import 'package:gymming_app/user_timetable/model/schedule_info.dart';

class ScheduleView extends StatelessWidget {
  final ScheduleInfo scheduleInfo;

  const ScheduleView({super.key, required this.scheduleInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      margin: EdgeInsets.only(bottom: 20, left: 10, right: 10),
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 15),
            padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 7.0),
            decoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
                "${scheduleInfo.startTime.hour} : ${scheduleInfo.startTime.minute}"),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                      "${scheduleInfo.lessonName} | ${scheduleInfo.trainerName}"),
                ),
                Container(
                  child: Text(
                      "${scheduleInfo.centerName} | ${scheduleInfo.centerLocation}"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
