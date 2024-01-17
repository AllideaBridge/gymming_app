import 'package:flutter/material.dart';
import 'package:gymming_app/common/utils/date_util.dart';
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
              Text(
                getScheduleListTitleString(context),
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
                          )))
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
        builder: (BuildContext context) {
          return Container(
            height: 428,
            child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                child: ScheduleClicked(scheduleInfo: schedule)),
          );
        });
  }

  String getScheduleListTitleString(BuildContext context) {
    var selectedDateTime = Provider.of<StateDateTime>(context).selectedDateTime;
    return "오늘은\n${DateUtil.getKoreanDay(selectedDateTime)}";
  }
}
