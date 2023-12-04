import 'package:flutter/material.dart';
import 'package:gymming_app/common/colors.dart';
import 'package:gymming_app/user_timetable/model/schedule_info.dart';
import 'package:provider/provider.dart';

import '../state/state_date_time.dart';
import '../user_timetable/schedule_cancel_confirm.dart';
import '../user_timetable/schedule_change.dart';

class ScheduleClicked extends StatelessWidget {
  final ScheduleInfo scheduleInfo;

  ScheduleClicked({
    Key? key,
    required this.scheduleInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BORDER_COLOR,
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "알림",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "${scheduleInfo.startTime}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "이전",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "${scheduleInfo.lessonName} | ${scheduleInfo.trainerName}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "장소",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "${scheduleInfo.centerName} | ${scheduleInfo.centerLocation}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[700], // Left Button Color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ScheduleCancelConfirm(scheduleInfo: scheduleInfo)),
                  );
                },
                child: Text(
                  "취소하기",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: SECONDARY_COLOR, // Right Button Color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ScheduleChange(
                                originDay: Provider.of<StateDateTime>(context)
                                    .selectedDateTime,
                                scheduleInfo: scheduleInfo,
                              )));
                },
                child: Text(
                  "변경하기",
                  style: TextStyle(
                    color: Colors.greenAccent,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
