import 'package:flutter/material.dart';
import 'package:gymming_app/state/state_date_time.dart';
import 'package:gymming_app/modal/schedule_clicked.dart';
import 'package:gymming_app/user_timetable/component/schedule_item.dart';
import 'package:provider/provider.dart';

import '../../common/colors.dart';
import '../model/schedule_info.dart';

class ScheduleList extends StatelessWidget {
  const ScheduleList({super.key});

  @override
  Widget build(BuildContext context) {
    List<ScheduleInfo> schedules = List.generate(
        3,
        (index) => ScheduleInfo(
            DateTime.now(), DateTime.now(), "PT", "김헬스", "GYMMING", "방이동", index));

    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        color: BACKGROUND_COLOR,
        child: Container(
          margin: EdgeInsets.only(top: 20, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "오늘은\n${Provider.of<StateDateTime>(context).selectedDateTime.month}월 ${Provider.of<StateDateTime>(context).selectedDateTime.day}일",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: schedules
                      .map((schedule) => GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(500))),
                                  builder: (BuildContext context) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),    // 왼쪽 상단 모서리
                                        topRight: Radius.circular(20),   // 오른쪽 상단 모서리
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
                            },
                            child: ScheduleItem(scheduleInfo: schedule),
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
}
