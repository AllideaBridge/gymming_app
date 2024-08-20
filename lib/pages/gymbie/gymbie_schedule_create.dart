import 'package:flutter/material.dart';
import 'package:gymming_app/components/common_header.dart';
import 'package:gymming_app/components/schedule_select_calendar.dart';
import 'package:gymming_app/services/models/trainer_list.dart';
import 'package:gymming_app/services/utils/date_util.dart';
import 'package:intl/intl.dart';

import '../../common/colors.dart';
import '../../components/time_select_table.dart';
import '../../services/models/available_times.dart';
import '../../services/models/schedule_user.dart';
import '../../services/repositories/schedule_repository.dart';
import 'gymbie_home/gymbie_home.dart';

class GymbieScheduleCreate extends StatefulWidget {
  final TrainerList selectedTrainer;
  final int userId;

  const GymbieScheduleCreate(
      {super.key, required this.userId, required this.selectedTrainer});

  @override
  State<GymbieScheduleCreate> createState() => _GymbieScheduleCreateState();
}

class _GymbieScheduleCreateState extends State<GymbieScheduleCreate> {
  DateTime _selectedDay = DateUtil.getKorTimeNow();
  String _selectedTime = '';
  List<AvailableTimes> _availableTimesList = [];

  void _changeSelectedDay(DateTime selectedDay) async {
    List<AvailableTimes> trainerList =
        await ScheduleRepository.getAvailableTimeListByTrainerIdAndDate(
            widget.selectedTrainer.trainerId, selectedDay);
    List<ScheduleUser> userSchedules =
        await ScheduleRepository.getScheduleByDay(widget.userId, selectedDay);
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
                  onPressed: () {
                    String requestTime =
                        DateUtil.convertDatabaseFormatFromDayAndTime(
                            _selectedDay, _selectedTime);

                    Future<bool> result = ScheduleRepository.createSchedule(
                        widget.userId,
                        widget.selectedTrainer.trainerId,
                        requestTime);
                    result.then((result) => {
                          if (result)
                            {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GymbieHome()),
                                (Route<dynamic> route) => false,
                              )
                            }
                        });
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
        availableTimeList.add(AvailableTimes(
            time: trainerList[i].time, isPossible: trainerList[i].isPossible));
        continue;
      }

      if (userUnavailableTimes.contains(trainerList[i].time)) {
        availableTimeList
            .add(AvailableTimes(time: trainerList[i].time, isPossible: false));
      } else {
        availableTimeList
            .add(AvailableTimes(time: trainerList[i].time, isPossible: true));
      }
    }

    return availableTimeList;
  }
}
