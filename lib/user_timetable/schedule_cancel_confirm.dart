import 'package:flutter/material.dart';
import 'package:gymming_app/common/colors.dart';
import 'package:gymming_app/common/constants.dart';
import 'package:gymming_app/user_timetable/model/schedule_info.dart';
import 'package:gymming_app/user_timetable/reason.dart';
import 'package:gymming_app/user_timetable/schedule_change_complete.dart';

import '../common/utils/date_util.dart';
import '../modal/model/reason_content.dart';
import 'component/schedule_header.dart';

class ScheduleCancelConfirm extends StatelessWidget {
  final ScheduleInfo scheduleInfo;

  const ScheduleCancelConfirm({super.key, required this.scheduleInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              ScheduleHeader(type: CANCEL),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 40, horizontal: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '운동 일정을\n취소하시겠습니까?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            buildTitleAndInfo('Time'),
                            SizedBox(height: 40),
                            buildTitleAndInfo('Lesson'),
                            SizedBox(height: 40),
                            buildTitleAndInfo('Location'),
                          ],
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: 350,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              DateTime now = DateTime.now();
                              int days = scheduleInfo.startTime
                                  .difference(
                                      DateTime(now.year, now.month, now.day))
                                  .inDays;
                              if (days >= scheduleInfo.remainDays) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ScheduleChangeComplete(
                                            type: CANCEL,
                                            originDay: scheduleInfo.startTime,
                                          )),
                                );
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Reason(
                                              reasonContent: ReasonContent(
                                                  cancelTitle,
                                                  cancelSubTitle,
                                                  changeReasons),
                                              originDay: scheduleInfo.startTime,
                                              selectedDay:
                                                  scheduleInfo.startTime,
                                              selectedTime:
                                                  '${scheduleInfo.startTime.hour}:00',
                                              type: CANCEL,
                                            )));
                              }
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
                              '취소하기',
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
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTitleAndInfo(String type) {
    String imgUrl = '';
    String title = '';
    String info = '';

    switch (type) {
      case 'Time':
        title = '일시';
        info = DateUtil.getKoreanDayAndHour(scheduleInfo.startTime);
        imgUrl = 'assets/clock.png';
        break;
      case 'Lesson':
        title = '수업';
        info = '${scheduleInfo.lessonName} | ${scheduleInfo.trainerName} 트레이너';
        imgUrl = 'assets/calendar.png';
        break;
      case 'Location':
        title = '장소';
        info = '${scheduleInfo.centerName} | ${scheduleInfo.centerLocation}';
        imgUrl = 'assets/location.png';
        break;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          imgUrl,
          width: 20,
          height: 20,
        ),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                  color: SECONDARY_COLOR,
                  fontSize: 18.0,
                )),
            SizedBox(height: 8),
            Text(
              info,
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
