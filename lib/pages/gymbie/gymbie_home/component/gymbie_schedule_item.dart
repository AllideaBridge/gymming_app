import 'package:flutter/material.dart';
import 'package:gymming_app/services/models/schedule_user.dart';
import 'package:intl/intl.dart';

import '../../../../common/colors.dart';

class ScheduleItem extends StatelessWidget {
  final ScheduleUser scheduleInfo;

  const ScheduleItem({super.key, required this.scheduleInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: BORDER_COLOR,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: PRIMARY_COLOR,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Text(startTimeToString(scheduleInfo.startTime),
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
          ),
          SizedBox(width: 20, height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${scheduleInfo.lessonName} | ${scheduleInfo.trainerName} 트레이너',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8, height: 8),
              Text(
                '${scheduleInfo.centerName} | ${scheduleInfo.centerLocation}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
            ],
          )
        ],
      ),
    );
  }

  String startTimeToString(DateTime startTime) {
    return DateFormat('hh:mm').format(startTime);
  }
}
