import 'package:flutter/material.dart';

import '../common/colors.dart';
import '../common/utils/date_util.dart';
import 'user_timetable.dart';

class ScheduleChanged extends StatelessWidget {
  const ScheduleChanged(
      {super.key,
      required this.originDay,
      required this.selectedDay,
      required this.selectedTime});

  final DateTime originDay;
  final DateTime selectedDay;
  final String selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "운동 일정을\n변경 하였습니다.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/change_compeleted.png'),
                    SizedBox(height: 80),
                    buildTitleAndTime('변경 전', originDay, '', SECONDARY_COLOR),
                    SizedBox(height: 40),
                    buildTitleAndTime(
                        '변경 후', selectedDay, selectedTime, Colors.white),
                  ],
                ),
              ),
              Center(
                child: SizedBox(
                  width: 350,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserTimeTable()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(BTN_COLOR),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    child: Text(
                      '확인',
                      style: TextStyle(
                        fontSize: 18,
                        color: PRIMARY_COLOR,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTitleAndTime(
      String title, DateTime time, String hour, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/clock.png',
          width: 20,
          height: 20,
        ),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                  color: color,
                  fontSize: 18.0,
                )),
            SizedBox(height: 8),
            Text(
              hour.isEmpty
                  ? DateUtil.getKoreanDayAndHour(time)
                  : DateUtil.getKoreanDayAndExactHour(time, hour),
              style: TextStyle(
                color: color,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
