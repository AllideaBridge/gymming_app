import 'package:flutter/material.dart';
import 'package:gymming_app/common/colors.dart';
import 'package:gymming_app/components/common_header.dart';
import 'package:gymming_app/components/schedule_select_calendar.dart';
import 'package:gymming_app/components/time_select_table.dart';
import 'package:gymming_app/services/models/available_times.dart';
import 'package:gymming_app/services/models/schedule_user.dart';
import 'package:gymming_app/services/repositories/schedule_repository.dart';
import 'package:gymming_app/services/utils/date_util.dart';
import 'package:gymming_app/state/info_state.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'gymbie_home/gymbie_home.dart';

class GymbieScheduleCreate extends StatefulWidget {
  final int selectedTrainerId;

  const GymbieScheduleCreate({super.key, required this.selectedTrainerId});

  @override
  State<GymbieScheduleCreate> createState() => _GymbieScheduleCreateState();
}

class _GymbieScheduleCreateState extends State<GymbieScheduleCreate> {
  late int userId = Provider.of<InfoState>(context, listen: false).userId!;

  DateTime _selectedDay = DateUtil.getKorTimeNow();
  String _selectedTime = '';
  List<AvailableTimes> _availableTimesList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CommonHeader(title: '일정 추가'),
              ScheduleSelectCalendar(
                  originDay: DateUtil.getKorTimeNow(),
                  changeSelectedDay: _changeSelectedDay),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: TimeSelectTable(
                  selectedDay: _selectedDay,
                  changeSelectedTime: _changeSelectedTime,
                  availableTimesList: _availableTimesList,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    String requestTime =
                        DateUtil.convertDatabaseFormatFromDayAndTime(
                            _selectedDay, _selectedTime);

                    String result = await ScheduleRepository().createSchedule(
                        userId, widget.selectedTrainerId, requestTime);

                    if (result == 'success') {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => GymbieHome()),
                        (Route<dynamic> route) => false,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR
                        .withOpacity(_selectedTime.isEmpty ? 0.3 : 1),
                    minimumSize: const Size.fromHeight(52),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  child: Text('추가 완료',
                      style: TextStyle(
                        color: INDICATOR_COLOR,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ))),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _changeSelectedDay(DateTime selectedDay) async {
    List<AvailableTimes> trainerList = await ScheduleRepository()
        .getAvailableTimeListByTrainerIdAndDate(
            widget.selectedTrainerId, selectedDay);
    List<ScheduleUser> userSchedules =
        await ScheduleRepository().getScheduleByDay(userId, selectedDay);
    List<AvailableTimes> result =
        getAvailableTimeListWithUser(trainerList, userSchedules);
    setState(() {
      _selectedDay = selectedDay;
      _selectedTime = '';
      _availableTimesList = result;
    });
  }

  void _changeSelectedTime(String selectedTime) {
    setState(() {
      _selectedTime = selectedTime;
    });
  }

  List<AvailableTimes> getAvailableTimeListWithUser(
      List<AvailableTimes> trainerList, List<ScheduleUser> userSchedules) {
    List<AvailableTimes> availableTimeList = [];
    List<String> userUnavailableTimes = [];
    for (ScheduleUser scheduleUser in userSchedules) {
      DateTime startTime = scheduleUser.startTime;
      int lessonMinutes = scheduleUser.lessonMinutes;
      DateTime endTime = startTime.add(Duration(minutes: lessonMinutes));

      while (startTime.isBefore(endTime)) {
        userUnavailableTimes.add(DateFormat("HH:mm").format(startTime));
        startTime = startTime.add(Duration(minutes: 30));
      }
    }

    for (int i = 0; i < trainerList.length; i++) {
      if (!trainerList[i].isPossible) {
        availableTimeList.add(
            AvailableTimes(trainerList[i].time, trainerList[i].isPossible));
        continue;
      }

      if (userUnavailableTimes.contains(trainerList[i].time)) {
        availableTimeList.add(AvailableTimes(trainerList[i].time, false));
      } else {
        availableTimeList.add(AvailableTimes(trainerList[i].time, true));
      }
    }

    return availableTimeList;
  }
}
