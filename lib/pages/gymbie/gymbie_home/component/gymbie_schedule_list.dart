import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:gymming_app/components/state_date_time.dart';
import 'package:gymming_app/pages/gymbie/gymbie_home/component/gymbie_schedule_item.dart';
import 'package:gymming_app/pages/gymbie/gymbie_home/component/gymbie_schedule_modal.dart';
import 'package:gymming_app/services//utils/date_util.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../../common/colors.dart';
import '../../../../services/models/schedule_info.dart';

class GymbieScheduleList extends StatelessWidget {
  late Future<List<ScheduleInfo>> schedules;

  Future<List<ScheduleInfo>> fetchScheduleOfDay(DateTime datetime) async {
    var url = Uri.parse(
        'http://10.0.2.2:5000/schedules/1/${datetime.year}/${datetime.month}/${datetime.day}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      final List<ScheduleInfo> result = [];
      for (Map<String, dynamic> item in body) {
        ScheduleInfo schedule = ScheduleInfo(
            DateTime.parse(item["schedule_start_time"]),
            DateTime.parse(item["schedule_start_time"]),
            item["lesson_name"],
            item["trainer_name"],
            item["center_name"],
            item["center_location"],
            5);
        result.add(schedule);
      }
      return result;
    } else {
      throw Exception("api response error occurs");
    }
  }

  @override
  Widget build(BuildContext context) {
    var selectedDateTime = Provider.of<StateDateTime>(context).selectedDateTime;
    schedules = fetchScheduleOfDay(selectedDateTime);

    print(selectedDateTime);
    print(schedules);

    return FutureBuilder(future: schedules, builder: (context, snapshot) {
      if (snapshot.hasData) {
        final schedules = snapshot.data!;
        return buildScheduleList(schedules, selectedDateTime, context);
      } else if (snapshot.hasError) {
        return Text("${snapshot.error}", style: TextStyle(color: Colors.white),);
      }

      return const CircularProgressIndicator();
    });
  }

  Widget buildScheduleList(List<ScheduleInfo> schedules, DateTime selectedDateTime, context) {
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
}
