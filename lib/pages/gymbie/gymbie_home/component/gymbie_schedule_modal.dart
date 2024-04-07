import 'package:flutter/material.dart';
import 'package:gymming_app/components/buttons/primary_button.dart';
import 'package:gymming_app/components/buttons/secondary_button.dart';
import 'package:gymming_app/components/icon_label.dart';
import 'package:gymming_app/services/models/schedule_info.dart';
import 'package:gymming_app/services/utils/date_util.dart';
import 'package:provider/provider.dart';

import '../../../../common/colors.dart';
import '../../../../components/state_date_time.dart';
import '../../../gymbie/gymbie_schedule_cancel.dart';
import '../../../gymbie/gymbie_schedule_change/gymbie_schedule_change.dart';

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
          IconLabel(
            iconData: Icons.alarm,
            title: "일시",
            content: DateUtil.getKoreanDayAndHour(scheduleInfo.startTime),
            titleColor: SECONDARY_COLOR,
            contentColor: Colors.white,
          ),
          IconLabel(
            iconData: Icons.calendar_today_outlined,
            title: "일정",
            content:
                '${scheduleInfo.lessonName} | ${scheduleInfo.trainerName} 트레이너',
            titleColor: SECONDARY_COLOR,
            contentColor: Colors.white,
          ),
          IconLabel(
            iconData: Icons.location_on,
            title: "장소",
            content:
                '${scheduleInfo.centerName} | ${scheduleInfo.centerLocation}',
            titleColor: SECONDARY_COLOR,
            contentColor: Colors.white,
          ),
          SizedBox(
              height: 56,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SecondaryButton(
                      title: "취소하기",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GymbieScheduleCancel(
                                    scheduleInfo: scheduleInfo)));
                      }),
                  SizedBox(width: 12),
                  PrimaryButton(
                      title: "변경하기",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GymbieScheduleChange(
                                      originDay:
                                          Provider.of<StateDateTime>(context)
                                              .selectedDateTime,
                                      scheduleInfo: scheduleInfo,
                                    )));
                      })
                ],
              ))
        ],
      ),
    );
  }
}
