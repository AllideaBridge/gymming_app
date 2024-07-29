import 'package:flutter/material.dart';
import 'package:gymming_app/components/common_header.dart';
import 'package:gymming_app/components/schedule_select_calendar.dart';
import 'package:gymming_app/components/time_select_table.dart';
import 'package:gymming_app/pages/gymbie/gymbie_schedule_resolve.dart';
import 'package:gymming_app/services/models/available_times.dart';
import 'package:gymming_app/services/repositories/schedule_repository.dart';
import 'package:gymming_app/services/utils/date_util.dart';

import '../../common/colors.dart';
import '../../common/constants.dart';
import '../../components/layouts/reason_content.dart';
import '../../components/layouts/reason_layout.dart';
import '../../services/models/schedule_user.dart';

class GymbieScheduleChange extends StatefulWidget {
  const GymbieScheduleChange(
      {super.key, required this.originDay, required this.scheduleDetail});

  final DateTime originDay;
  final ScheduleUser scheduleDetail;

  @override
  State<GymbieScheduleChange> createState() => _GymbieScheduleChangeState();
}

class _GymbieScheduleChangeState extends State<GymbieScheduleChange> {
  DateTime _selectedDay = DateTime.now();
  String _selectedTime = '';
  List<AvailableTimes> _availableTimesList = [];

  void _changeSelectedDay(DateTime selectedDay) async {
    var result =
        await ScheduleRepository.getAvailableTimeListByTrainerIdAndDate(
            widget.scheduleDetail.trainerId, selectedDay);
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
                CommonHeader(title: '일정 $CHANGE'),
                ScheduleSelectCalendar(
                  originDay: widget.originDay,
                  changeSelectedDay: _changeSelectedDay,
                ),
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
                buildFooterButton(
                    context,
                    _selectedTime.isEmpty
                        ? PRIMARY_COLOR.withOpacity(0.3)
                        : PRIMARY_COLOR),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ));
  }

  SizedBox buildFooterButton(BuildContext context, Color buttonColor) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed:
            _selectedTime.isEmpty ? null : () => clickChangeButton(context),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
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
    );
  }

  void clickChangeButton(context) async {
    DateTime now = DateTime.now();
    int days = widget.originDay
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;

    if (days >= widget.scheduleDetail.lessonChangeRange) {
      var requestTime = DateUtil.convertDatabaseFormatFromDayAndTime(
          _selectedDay, _selectedTime);

      final response = await ScheduleRepository.updateSchedule(
          widget.scheduleDetail.scheduleId, requestTime);

      if (response) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GymbieScheduleResolve(
                    type: CHANGE,
                    originDay: widget.scheduleDetail.startTime,
                    selectedDay: _selectedDay,
                    selectedTime: _selectedTime,
                  )),
        );
      }
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Reason(
                    reasonContent: ReasonContent(
                        CHANGE_TITLE, CHANEG_SUBTITLE, CHANGE_REASONS),
                    scheduleDetail: widget.scheduleDetail,
                    selectedDay: _selectedDay,
                    selectedTime: _selectedTime,
                    type: CHANGE,
                  )));
    }
  }
}
