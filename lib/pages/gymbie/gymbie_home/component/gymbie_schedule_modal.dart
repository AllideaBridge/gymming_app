import 'package:flutter/material.dart';
import 'package:gymming_app/components/buttons/primary_button.dart';
import 'package:gymming_app/components/buttons/secondary_button.dart';
import 'package:gymming_app/components/icon_label.dart';
import 'package:gymming_app/services/models/schedule_user.dart';
import 'package:gymming_app/services/utils/date_util.dart';
import 'package:provider/provider.dart';

import '../../../../common/colors.dart';
import '../../../../components/state_date_time.dart';
import '../../../gymbie/gymbie_schedule_cancel.dart';
import '../../gymbie_schedule_change.dart';

class GymbieScheduleModal extends StatelessWidget {
  final ScheduleUser scheduleDetail;
  final int userId;

  const GymbieScheduleModal(
      {super.key, required this.scheduleDetail, required this.userId});

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
            content: DateUtil.getKoreanDayAndHour(scheduleDetail.startTime),
            titleColor: SECONDARY_COLOR,
            contentColor: Colors.white,
          ),
          IconLabel(
            iconData: Icons.calendar_today_outlined,
            title: "일정",
            content:
                '${scheduleDetail.lessonName} | ${scheduleDetail.trainerName} 트레이너',
            titleColor: SECONDARY_COLOR,
            contentColor: Colors.white,
          ),
          IconLabel(
            iconData: Icons.location_on,
            title: "장소",
            content:
                '${scheduleDetail.centerName} | ${scheduleDetail.centerLocation}',
            titleColor: SECONDARY_COLOR,
            contentColor: Colors.white,
          ),
          scheduleDetail.startTime.isAfter(DateUtil.getKorTimeNow())
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: SecondaryButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GymbieScheduleCancel(
                                      scheduleDetail: scheduleDetail)));
                        },
                        title: '취소하기',
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                        child: PrimaryButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GymbieScheduleChange(
                                      originalSelectedDay:
                                          Provider.of<StateDateTime>(context)
                                              .selectedDateTime,
                                      scheduleDetail: scheduleDetail,
                                    )));
                      },
                      title: '변경하기',
                    ))
                  ],
                )
              : SizedBox(
                  height: 56,
                )
        ],
      ),
    );
  }
}
