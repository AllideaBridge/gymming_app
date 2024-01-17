import 'package:flutter/material.dart';
import 'package:gymming_app/common/colors.dart';
import 'package:gymming_app/common/utils/date_util.dart';
import 'package:gymming_app/user_timetable/model/schedule_info.dart';
import 'package:provider/provider.dart';

import '../state/state_date_time.dart';
import '../user_timetable/schedule_cancel_confirm.dart';
import '../user_timetable/schedule_change.dart';

class ScheduleClicked extends StatelessWidget {
  final ScheduleInfo scheduleInfo;

  const ScheduleClicked({super.key, required this.scheduleInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BORDER_COLOR,
      padding: EdgeInsets.fromLTRB(20, 32, 20, 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          clickedScheduleItem(Icons.alarm, "일시",
              DateUtil.getKoreanDayAndHour(scheduleInfo.startTime)),
          clickedScheduleItem(
            Icons.calendar_today_outlined,
            "일정",
            '${scheduleInfo.lessonName} | ${scheduleInfo.trainerName} 트레이너',
          ),
          clickedScheduleItem(Icons.location_on, "장소",
              '${scheduleInfo.centerName} | ${scheduleInfo.centerLocation}'),
          SizedBox(
              height: 56,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  secondaryButton(
                      "취소하기",
                      context,
                      MaterialPageRoute(
                          builder: (context) => ScheduleCancelConfirm(
                              scheduleInfo: scheduleInfo))),
                  SizedBox(width: 12),
                  primaryButton(
                      "변경하기",
                      context,
                      MaterialPageRoute(
                          builder: (context) => ScheduleChange(
                                originDay: Provider.of<StateDateTime>(context)
                                    .selectedDateTime,
                                scheduleInfo: scheduleInfo,
                              ))),
                ],
              ))
        ],
      ),
    );
  }

  Widget clickedScheduleItem(IconData iconData, String title, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          iconData,
          color: SECONDARY_COLOR,
          size: 20,
        ),
        SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: SECONDARY_COLOR, fontSize: 18),
            ),
            Text(
              content,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            )
          ],
        )
      ],
    );
  }

  Widget secondaryButton(
      String title, BuildContext context, MaterialPageRoute route) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: BTN_COLOR,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            )),
        onPressed: () {
          Navigator.push(context, route);
        },
        child: Text(
          title,
          style: TextStyle(
            color: PRIMARY_COLOR,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget primaryButton(
      String title, BuildContext context, MaterialPageRoute route) {
    return Expanded(
        child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: PRIMARY_COLOR,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          )),
      onPressed: () {
        Navigator.push(context, route);
      },
      child: Text(
        title,
        style: TextStyle(
          color: INDICATOR_COLOR,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    ));
  }
}
