import 'package:flutter/material.dart';
import 'package:gymming_app/state/state_week.dart';
import 'package:gymming_app/user_timetable/component/schedule_day.dart';
import 'package:provider/provider.dart';

import '../../common/constants.dart';

class ScheduleWeek extends StatelessWidget {
  const ScheduleWeek({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int year = Provider.of<StateWeek>(context).year;
    int month = Provider.of<StateWeek>(context).month;
    int dayOfSunday = Provider.of<StateWeek>(context).dayOfSunday;

    var lastDayOfMonth = year % 4 == 0 ? leapYear : notLeapYear;
    var monthArr = [];
    var dayArr = [];

    for (int i = 0; i < 7; i++) {
      if (dayOfSunday + i > lastDayOfMonth[month - 1]) {
        monthArr.add(month + 1);
        dayArr.add(dayOfSunday + i - lastDayOfMonth[month - 1]);
      } else {
        monthArr.add(month);
        dayArr.add(dayOfSunday + i);
      }
    }

    return Container(
      margin: EdgeInsets.only(bottom: 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ScheduleDay(month: monthArr[0], day: dayArr[0], dayOfWeek: "SUN"),
          ScheduleDay(month: monthArr[1], day: dayArr[1], dayOfWeek: "MON"),
          ScheduleDay(month: monthArr[2], day: dayArr[2], dayOfWeek: "TUE"),
          ScheduleDay(month: monthArr[3], day: dayArr[3], dayOfWeek: "WED"),
          ScheduleDay(month: monthArr[4], day: dayArr[4], dayOfWeek: "THR"),
          ScheduleDay(month: monthArr[5], day: dayArr[5], dayOfWeek: "FRI"),
          ScheduleDay(month: monthArr[6], day: dayArr[6], dayOfWeek: "SAT")
        ],
      ),
    );
  }
}
