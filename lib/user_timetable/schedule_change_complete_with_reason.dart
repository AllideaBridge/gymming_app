import 'package:flutter/material.dart';
import 'package:gymming_app/common/colors.dart';
import 'package:gymming_app/user_timetable/user_timetable.dart';

import '../common/constants.dart';
import '../common/utils/date_util.dart';

class ScheduleChangeCompleteWithReason extends StatelessWidget {
  final String type;
  final DateTime originDay;
  final DateTime selectedDay;
  final String selectedTime;
  final String reason;

  const ScheduleChangeCompleteWithReason(
      {super.key,
      required this.type,
      required this.originDay,
      required this.selectedDay,
      required this.selectedTime,
      required this.reason});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(children: [
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '운동 일정 $type을(를)\n신청하셨습니다.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '일정 $type이(가) 확정된 것이 아니며, 트레이너 및\n지점 확인 후 승인 여부를 알려드리겠습니다.\n(최대 3시간 소요)',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 40),
                  buildTitleAndTime(type == CHANGE ? '변경 전' : '취소 일정',
                      originDay, '', SECONDARY_COLOR),
                  Visibility(
                    visible: type == CHANGE,
                    child: SizedBox(height: 40),
                  ),
                  Visibility(
                    visible: type == CHANGE,
                    child: buildTitleAndTime(
                        '변경 후', selectedDay, selectedTime, Colors.white),
                  ),
                  SizedBox(height: 40),
                  buildTitleAndReason('$type 사유', reason),
                ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 169,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => UserTimeTable()),
                      (Route<dynamic> route) =>
                          false, // 모든 라우트를 제거하므로 false를 반환합니다.
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
                    '변경 취소',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 169,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => UserTimeTable()),
                      (Route<dynamic> route) =>
                          false, // 모든 라우트를 제거하므로 false를 반환합니다.
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
            ],
          ),
        ]),
      ),
    ));
  }

  Widget buildTitleAndTime(
      String title, DateTime? time, String? hour, Color color) {
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
              hour!.isEmpty
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

  Widget buildTitleAndReason(String title, String reason) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/talkBox.png',
          width: 20,
          height: 20,
        ),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                )),
            SizedBox(height: 8),
            Text(
              reason,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
