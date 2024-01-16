import 'package:flutter/material.dart';
import 'package:gymming_app/state/state_date_time.dart';
import 'package:gymming_app/modal/schedule_clicked.dart';
import 'package:gymming_app/user_timetable/component/schedule_item.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../common/colors.dart';
import '../model/schedule_info.dart';

class ScheduleList extends StatelessWidget {
  const ScheduleList({super.key});

  @override
  Widget build(BuildContext context) {
    List<ScheduleInfo> schedules = List.generate(
        3,
        (index) => ScheduleInfo(DateTime.now(), DateTime.now(), "PT", "김헬스",
            "GYMMING", "방이동", index));

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          color: BACKGROUND_COLOR,
        ),
        margin: EdgeInsets.only(top: 54),
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 32, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(getScheduleListTitleString(context),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 28, height: 28),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: schedules
                      .map((schedule) => GestureDetector(
                            onTap: () {
                              showScheduleBottomSheet(context, schedule);
                            },
                            child: Column(
                              children: [
                                ScheduleItem(scheduleInfo: schedule),
                                SizedBox(width: 28, height: 28),
                              ],
                            )

                          ))
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showScheduleBottomSheet(BuildContext context, ScheduleInfo schedule) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(500))),
        builder: (BuildContext context) {
          return ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft:
                  Radius.circular(20), // 왼쪽 상단 모서리
              topRight:
                  Radius.circular(20), // 오른쪽 상단 모서리
            ),
            child: Scaffold(
              body: Container(
                decoration: BoxDecoration(
                    color: Color(0xff2d2d2d),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(25),
                    )),
                child: ScheduleClicked(
                    scheduleInfo: schedule),
              ),
            ),
          );
        });
  }

  String getScheduleListTitleString(BuildContext context) {
    var selectedDateTime = Provider.of<StateDateTime>(context).selectedDateTime;
    String yoil = DateFormat('E', 'ko_KR').format(selectedDateTime);
    return  "오늘은\n${selectedDateTime.month}월 ${selectedDateTime.day}일 ${yoil}요일";
  }
}
