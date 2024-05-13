import 'package:flutter/material.dart';
import 'package:gymming_app/components/icon_label.dart';
import 'package:gymming_app/components/layouts/reason_layout.dart';
import 'package:gymming_app/pages/gymbie/gymbie_schedule_resolve.dart';
import 'package:gymming_app/services/models/schedule_detail.dart';
import 'package:gymming_app/services/repositories/schedule_repository.dart';
import 'package:http/http.dart' as http;

import '../../common/colors.dart';
import '../../common/constants.dart';
import '../../components/common_header.dart';
import '../../components/layouts/reason_content.dart';
import '../../services/utils/date_util.dart';

class GymbieScheduleCancel extends StatelessWidget {
  final ScheduleRepository scheduleRepository =
      ScheduleRepository(client: http.Client());
  final ScheduleDetail scheduleDetail;

  GymbieScheduleCancel({super.key, required this.scheduleDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CommonHeader(title: '일정 $CANCEL'),
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
                            IconLabel(
                                iconData: Icons.alarm,
                                title: '일시',
                                content: DateUtil.getKoreanDayAndHour(
                                    scheduleDetail.startTime),
                                titleColor: SECONDARY_COLOR,
                                contentColor: Colors.white),
                            SizedBox(height: 40),
                            IconLabel(
                                iconData: Icons.calendar_today_outlined,
                                title: '일정',
                                content:
                                    '${scheduleDetail.lessonName} | ${scheduleDetail.trainerName} 트레이너',
                                titleColor: SECONDARY_COLOR,
                                contentColor: Colors.white),
                            SizedBox(height: 40),
                            IconLabel(
                                iconData: Icons.location_on_outlined,
                                title: '장소',
                                content:
                                    '${scheduleDetail.centerName} | ${scheduleDetail.centerLocation}',
                                titleColor: SECONDARY_COLOR,
                                contentColor: Colors.white),
                          ],
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: 350,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              showAfterClickCancel(context);
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

  void showAfterClickCancel(context) async {
    DateTime now = DateTime.now();
    int days = scheduleDetail.startTime
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;

    if (days >= scheduleDetail.lessonChangeRange) {
      //예약일까지의 날짜 차이가 remainDays보다 긴 경우 -> 즉시 취소 가능
      // api 호출
      var cancelResult =
          await scheduleRepository.cancelSchedule(scheduleDetail.scheduleId);
      //api 성공 -> 성공 페이지로 이동
      if (cancelResult == true) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ScheduleChangeComplete(
                    type: CANCEL,
                    originDay: scheduleDetail.startTime,
                  )),
        );
      } else {
        //api 실패 -> 유지 (에러 메세지 띄우기?)
      }
    } else {
      //예약일까지의 날짜 차이가 remainDays보다 짧은 경우 -> 취소 사유 입력
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Reason(
                    reasonContent: ReasonContent(
                        CANCEL_TITLE, CANCEL_SUBTITLE, CHANGE_REASONS),
                    scheduleDetail: scheduleDetail,
                    selectedDay: scheduleDetail.startTime,
                    selectedTime: '${scheduleDetail.startTime.hour}:00',
                    type: CANCEL,
                  )));
    }
  }
}
