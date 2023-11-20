import 'package:flutter/material.dart';
import 'package:gymming_app/common/constants.dart';
import 'package:gymming_app/user_timetable/model/schedule_info.dart';
import 'package:gymming_app/user_timetable/reason.dart';
import 'package:gymming_app/user_timetable/schedule_canceled.dart';
import 'package:gymming_app/user_timetable/schedule_changed.dart';

import '../modal/model/reason_content.dart';
import 'component/schedule_header.dart';

class ScheduleCancelConfirm extends StatelessWidget {
  final ScheduleInfo scheduleInfo;

  const ScheduleCancelConfirm({super.key, required this.scheduleInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ScheduleHeader(type:CANCEL),
              Text(
                '운동 일정을\n취소하시겠습니까?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 60),
              Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Icon(Icons.calendar_today,
                              color: Colors.white, size: 30.0),
                          Text("일시",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ))
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        '${scheduleInfo.startTime.month}월 ${scheduleInfo.startTime.day}일 ${scheduleInfo.startTime.hour}:00',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Icon(Icons.calendar_today,
                              color: Colors.white, size: 30.0),
                          Text("일정",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ))
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        '${scheduleInfo.lessonName} | ${scheduleInfo.trainerName}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Icon(Icons.calendar_today,
                              color: Colors.white, size: 30.0),
                          Text("장소",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ))
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        '${scheduleInfo.centerName} | ${scheduleInfo.centerLocation}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 40),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ElevatedButton(
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
                              builder: (context) => ScheduleCanceled(lessontime: scheduleInfo.startTime)),
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
                                  selectedDay: scheduleInfo.startTime,
                                  selectedTime: '${scheduleInfo.startTime.hour}:00',
                                  type: CANCEL,
                                )));
                      }

                    },
                    child: Text('취소하기'),
                    style: ElevatedButton.styleFrom(primary: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
