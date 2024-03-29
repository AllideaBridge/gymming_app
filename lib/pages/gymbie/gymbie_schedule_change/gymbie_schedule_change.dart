import 'package:flutter/material.dart';
import 'package:gymming_app/components/common_header.dart';
import 'package:gymming_app/pages/gymbie/gymbie_schedule_change/component/gymbie_change_calendar.dart';
import 'package:gymming_app/pages/gymbie/gymbie_schedule_change/component/gymbie_select_time.dart';
import 'package:gymming_app/pages/gymbie/gymbie_schedule_resolve.dart';
import 'package:gymming_app/services/models/available_times.dart';
import 'package:gymming_app/services/repositories/schedule_repository.dart';

import '../../../common/colors.dart';
import '../../../common/constants.dart';
import '../../../components/layouts/reason_content.dart';
import '../../../components/layouts/reason_layout.dart';
import '../../../services/models/schedule_info.dart';

class GymbieScheduleChange extends StatefulWidget {
  const GymbieScheduleChange(
      {super.key, required this.originDay, required this.scheduleInfo});

  final DateTime originDay;
  final ScheduleInfo scheduleInfo;

  @override
  State<GymbieScheduleChange> createState() => _GymbieScheduleChangeState();
}

class _GymbieScheduleChangeState extends State<GymbieScheduleChange> {
  DateTime _selectedDay = DateTime.now();
  String _selectedTime = '';
  late AvailableTimes _availableTimes = AvailableTimes(
      availabilityEndTime: '',
      availabilityStartTime: '',
      lessonMinutes: 30,
      lessonChangeRange: 10,
      schedules: []);

  void _changeSelectedDay(DateTime selectedDay) async {
    var result =
        await ScheduleRepository.getAvailableTimeListByTrainerIdAndDate(
            '1', selectedDay.year, selectedDay.month, selectedDay.day);
    setState(() {
      _selectedDay = selectedDay;
      _selectedTime = '';
      _availableTimes = result;
    });
  }

  void _changeSelectedTime(String selectedTime) {
    setState(() {
      _selectedTime = selectedTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color buttonColor =
        _selectedTime.isEmpty ? PRIMARY_COLOR.withOpacity(0.3) : PRIMARY_COLOR;

    return Scaffold(
        extendBody: true,
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CommonHeader(title: '일정 $CHANGE'),
                GymbieChangeCalendar(
                  originDay: widget.originDay,
                  changeSelectedDay: _changeSelectedDay,
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: GymbieSelectTime(
                    selectedDay: _selectedDay,
                    changeSelectedTime: _changeSelectedTime,
                    availableTimes: _availableTimes,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 350,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _selectedTime.isEmpty
                        ? null
                        : () {
                            DateTime now = DateTime.now();
                            int days = widget.originDay
                                .difference(
                                    DateTime(now.year, now.month, now.day))
                                .inDays;
                            if (days >= widget.scheduleInfo.remainDays) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ScheduleChangeComplete(
                                          type: CHANGE,
                                          originDay:
                                              widget.scheduleInfo.startTime,
                                          selectedDay: _selectedDay,
                                          selectedTime: _selectedTime,
                                        )),
                              );
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Reason(
                                            reasonContent: ReasonContent(
                                                CHANGE_TITLE,
                                                CHANEG_SUBTITLE,
                                                CHANGE_REASONS),
                                            originDay:
                                                widget.scheduleInfo.startTime,
                                            selectedDay: _selectedDay,
                                            selectedTime: _selectedTime,
                                            type: CHANGE,
                                          )));
                            }
                          },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(buttonColor),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    child: const Text(
                      '변경 완료',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ));
  }
}
