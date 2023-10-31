import 'package:flutter/material.dart';
import 'package:gymming_app/common/colors.dart';
import 'package:gymming_app/user_timetable/model/schedule_info.dart';

class ScheduleItem extends StatelessWidget {
  final ScheduleInfo scheduleInfo;

  const ScheduleItem({super.key, required this.scheduleInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: BORDER_COLOR,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              "${scheduleInfo.startTime.hour} : ${scheduleInfo.startTime.minute}",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 8.0), // 간격 조절
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${scheduleInfo.lessonName} | ${scheduleInfo.trainerName}",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${scheduleInfo.centerName} | ${scheduleInfo.centerLocation}",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// ${scheduleInfo.startTime.hour} : ${scheduleInfo.startTime.minute}
// ${scheduleInfo.lessonName} | ${scheduleInfo.trainerName}
// "${scheduleInfo.centerName} | ${scheduleInfo.centerLocation}"



// Container(
// color: Colors.blueGrey,
// margin: EdgeInsets.only(top:30, right: 10),
// padding: EdgeInsets.all(5),
// child: Row(
// children: [
// Container(
// margin: EdgeInsets.only(bottom: 15),
// padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 7.0),
// decoration: BoxDecoration(
// color: Colors.greenAccent,
// borderRadius: BorderRadius.circular(15),
// ),
// child: Text(
// "${scheduleInfo.startTime.hour} : ${scheduleInfo.startTime.minute}"),
// ),
// Container(
// margin: EdgeInsets.only(left: 20),
// padding: EdgeInsets.symmetric(vertical: 10),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Container(
// child: Text(
// "${scheduleInfo.lessonName} | ${scheduleInfo.trainerName}"),
// ),
// Container(
// child: Text(
// "${scheduleInfo.centerName} | ${scheduleInfo.centerLocation}"),
// ),
// ],
// ),
// ),
// ],
// ),
// );