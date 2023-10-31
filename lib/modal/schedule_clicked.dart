import 'package:flutter/material.dart';
import 'package:gymming_app/common/colors.dart';
import 'package:gymming_app/common/constants.dart';
import 'package:gymming_app/modal/model/reason_content.dart';
import 'package:gymming_app/modal/reason.dart';
import 'package:gymming_app/user_timetable/component/schedule_changed.dart';
import 'package:gymming_app/user_timetable/model/schedule_info.dart';

import '../user_timetable/model/modal_content.dart';

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
                    MaterialPageRoute(builder: (context) => ScheduleChanged(beforeTime: DateTime.now(), afterTime: DateTime.now())),
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
                  showBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25.0))),
                      builder: (BuildContext context) {
                        return Reason(
                            reasonContent: ReasonContent(
                                changeTitle, changeSubTitle, changeReasons));
                      });
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
