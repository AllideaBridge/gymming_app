import 'package:flutter/material.dart';
import 'package:gymming_app/components/state_date_time.dart';
import 'package:gymming_app/pages/gymbie/gymbie_home/component/gymbie_schedule_item.dart';
import 'package:gymming_app/pages/gymbie/gymbie_home/component/gymbie_schedule_modal.dart';
import 'package:gymming_app/services//utils/date_util.dart';
import 'package:gymming_app/services/repositories/schedule_repository.dart';
import 'package:provider/provider.dart';

import '../../../../common/colors.dart';
import '../../../../services/models/schedule_user.dart';

class GymbieScheduleList extends StatelessWidget {
  final int userId;

  const GymbieScheduleList({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    var selectedDateTime = Provider.of<StateDateTime>(context).selectedDateTime;
    Future<List<ScheduleUser>> schedules =
        ScheduleRepository.getScheduleByDay(userId, selectedDateTime);

    return FutureBuilder(
        future: schedules,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final schedules = snapshot.data!;
            return buildScheduleList(schedules, selectedDateTime, context);
          } else if (snapshot.hasError) {
            return Text(
              "${snapshot.error}",
              style: TextStyle(color: Colors.white),
            );
          }
          return const CircularProgressIndicator();
        });
  }

  Widget buildScheduleList(
      List<ScheduleUser> schedules, DateTime selectedDateTime, context) {
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
                DateUtil.getKoreanDay(selectedDateTime),
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

  void showScheduleBottomSheet(BuildContext context, ScheduleUser schedule) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 428,
            child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                child: GymbieScheduleModal(
                    scheduleDetail: schedule, userId: userId)),
          );
        });
  }
}
