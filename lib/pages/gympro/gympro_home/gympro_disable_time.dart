import 'package:flutter/material.dart';
import 'package:gymming_app/common/colors.dart';
import 'package:gymming_app/components/common_header.dart';
import 'package:gymming_app/components/schedule_select_calendar.dart';
import 'package:gymming_app/components/time_select_table.dart';
import 'package:gymming_app/services/models/available_times.dart';
import 'package:gymming_app/services/repositories/schedule_repository.dart';
import 'package:gymming_app/services/utils/date_util.dart';
import 'package:gymming_app/state/info_state.dart';
import 'package:provider/provider.dart';

class GymproDisableTime extends StatefulWidget {
  const GymproDisableTime({super.key});

  @override
  State<StatefulWidget> createState() => _GymproDisableTimeState();
}

class _GymproDisableTimeState extends State<GymproDisableTime> {
  late int trainerId =
      Provider.of<InfoState>(context, listen: false).trainerId!;

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
          backgroundColor: WidgetStateProperty.all<Color>(buttonColor),
          shape: WidgetStateProperty.all<OutlinedBorder>(
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

  void _changeSelectedDay(DateTime selectedDay) async {
    var result = await ScheduleRepository()
        .getAvailableTimeListByTrainerIdAndDate(trainerId, selectedDay);

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

  void clickConfirm(context) {
    var dateTime = DateUtil.convertDatabaseFormatFromDayAndTime(
        _selectedDay, _selectedTime);

    ScheduleRepository().createSchedule(0, trainerId, dateTime);
  }
}
