import 'package:flutter/material.dart';
import 'package:gymming_app/services/utils/date_util.dart';

import '../../../common/colors.dart';
import '../../../components/common_header.dart';
import '../../../components/schedule_select_calendar.dart';
import '../../../components/time_select_table.dart';
import '../../../services/models/available_times.dart';
import '../../../services/repositories/schedule_repository.dart';

class GymproDisableTime extends StatefulWidget {
  final int trainerId;

  const GymproDisableTime({super.key, required this.trainerId});

  @override
  State<StatefulWidget> createState() => _GymproDisableTimeState();
}

class _GymproDisableTimeState extends State<GymproDisableTime> {
  DateTime _selectedDay = DateTime.now();
  String _selectedTime = '';
  List<AvailableTimes> _availableTimesList = [];

  void _changeSelectedDay(DateTime selectedDay) async {
    var result =
        await ScheduleRepository.getAvailableTimeListByTrainerIdAndDate(
            widget.trainerId, selectedDay);
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
                CommonHeader(title: '일정 잠금'),
                ScheduleSelectCalendar(
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
            )),
      ),
    );
  }

  SizedBox buildFooterButton(BuildContext context, Color buttonColor) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _selectedTime.isEmpty ? null : () => clickConfirm(context),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        child: const Text(
          '잠그기',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void clickConfirm(context) {
    //todo 스케쥴 생성 변경 필요
    var dateTime = DateUtil.convertDatabaseFormatFromDayAndTime(
        _selectedDay, _selectedTime);
    ScheduleRepository.createSchedule(0, widget.trainerId, dateTime);
    return;
  }
}
