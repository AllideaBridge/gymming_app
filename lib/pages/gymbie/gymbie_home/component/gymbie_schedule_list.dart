import 'package:flutter/material.dart';
import 'package:gymming_app/common/colors.dart';
import 'package:gymming_app/components/state_date_time.dart';
import 'package:gymming_app/pages/gymbie/gymbie_home/component/gymbie_schedule_item.dart';
import 'package:gymming_app/pages/gymbie/gymbie_home/component/gymbie_schedule_modal.dart';
import 'package:gymming_app/services//utils/date_util.dart';
import 'package:gymming_app/services/models/schedule_user.dart';
import 'package:gymming_app/services/repositories/schedule_repository.dart';
import 'package:gymming_app/state/info_state.dart';
import 'package:provider/provider.dart';

class GymbieScheduleList extends StatelessWidget {
  const GymbieScheduleList({super.key});

  @override
  Widget build(BuildContext context) {
    var selectedDateTime = Provider.of<StateDateTime>(context).selectedDateTime;
    Future<List<ScheduleUser>> schedules = ScheduleRepository()
        .getScheduleByDay(
            Provider.of<InfoState>(context, listen: false).userId!,
            selectedDateTime);

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
          return SizedBox(
            height: 428,
            child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                child: GymbieScheduleModal(
                    scheduleDetail: schedule,
                    userId: Provider.of<InfoState>(context, listen: false)
                        .userId!)),
          );
        });
  }
}
