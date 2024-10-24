import 'package:flutter/material.dart';
import 'package:gymming_app/common/colors.dart';
import 'package:gymming_app/common/constants.dart';
import 'package:gymming_app/components/common_header.dart';
import 'package:gymming_app/components/icon_label.dart';
import 'package:gymming_app/components/layouts/reason_layout.dart';
import 'package:gymming_app/pages/gymbie/gymbie_schedule_resolve.dart';
import 'package:gymming_app/services/models/reason_content.dart';
import 'package:gymming_app/services/models/schedule_user.dart';
import 'package:gymming_app/services/repositories/schedule_repository.dart';
import 'package:gymming_app/services/utils/date_util.dart';

class GymbieScheduleCancel extends StatelessWidget {
  final ScheduleUser scheduleDetail;

  const GymbieScheduleCancel({super.key, required this.scheduleDetail});

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
                                  WidgetStateProperty.all<Color>(BTN_COLOR),
                              shape: WidgetStateProperty.all<OutlinedBorder>(
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
    DateTime now = DateUtil.getKorTimeNow();
    int days = scheduleDetail.startTime
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;

    if (days >= scheduleDetail.lessonChangeRange) {
      var result =
          await ScheduleRepository().cancelSchedule(scheduleDetail.scheduleId);

      if (result.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GymbieScheduleResolve(
                    type: CANCEL,
                    originDay: scheduleDetail.startTime,
                  )),
        );
      }
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ReasonLayout(
                    reasonContent: ReasonContent(
                        CANCEL_TITLE, CANCEL_SUBTITLE, CHANGE_REASONS),
                    scheduleDetail: scheduleDetail,
                    originalDatetime: scheduleDetail.startTime,
                    type: ChangeTicketType.CANCEL,
                    requesterType: 'USER',
                  )));
    }
  }
}
