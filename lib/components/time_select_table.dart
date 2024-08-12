import 'package:flutter/material.dart';
import 'package:gymming_app/services/models/available_times.dart';

import '../common/colors.dart';

class TimeSelectTable extends StatefulWidget {
  const TimeSelectTable(
      {super.key,
      required this.selectedDay,
      required this.changeSelectedTime,
      required this.availableTimesList});

  final DateTime selectedDay;
  final Function(String) changeSelectedTime;
  final List<AvailableTimes> availableTimesList;

  @override
  State<TimeSelectTable> createState() => _TimeSelectTableState();
}

class _TimeSelectTableState extends State<TimeSelectTable> {
  List<AvailableTimes> times = [];

  String selectedTime = '';
  String endTime = '';

  void onPressedTimeButton(String newTime, int selectedTimeIndex) {
    // 30분 후의 시간도 available한지 확인해야 한다.
    // 맨 마지막 타임을 고를 수 없으므로 불가
    if (selectedTimeIndex == times.length - 1) {
      return;
    }
    // 끝나는 타임은 선택된 칩의 다음 인덱스
    endTime = times[selectedTimeIndex + 1].time;

    // 끝나는 타임이 선택 불가능한 경우 불가
    if (!times[selectedTimeIndex + 1].isPossible) {
      return;
    }

    // 선택한 시간이 지금보다 과거인 경우 불가
    int selectedHour = int.parse(newTime.split(":")[0]);
    int selectedMinute = int.parse(newTime.split(":")[1]);
    DateTime selectedDateTime = DateTime(
        widget.selectedDay.year,
        widget.selectedDay.month,
        widget.selectedDay.day,
        selectedHour,
        selectedMinute);
    if (selectedDateTime.isBefore(DateTime.now())) {
      return;
    }

    setState(() {
      selectedTime = newTime;
    });
    widget.changeSelectedTime(newTime);
  }

  @override
  void didUpdateWidget(TimeSelectTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDay != oldWidget.selectedDay) {
      selectedTime = '';
      endTime = '';
      times = widget.availableTimesList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 81.5 / 36,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8),
        itemBuilder: (BuildContext context, int index) {
          return buildElevatedButton(
              times[index].isPossible,
              times[index].time == selectedTime || times[index].time == endTime,
              times[index].time, (String newTime) {
            onPressedTimeButton(newTime, index);
          });
        },
        itemCount: times.length);
  }
}

Widget buildElevatedButton(bool isPossible, bool isSelected, String buttonText,
    void Function(String) onPressed) {
  return ElevatedButton(
    onPressed: isPossible ? () => onPressed(buttonText) : null,
    style: isPossible
        ? (isSelected ? selectedButtonStyle : defaultButtonStyle)
        : disabledButtonStyle,
    child: Text(buttonText,
        style: isPossible
            ? (isSelected ? selectedTextStyle : defaultTextStyle)
            : disabledTextStyle),
  );
}

final ButtonStyle disabledButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(BTN_COLOR.withOpacity(0.3)),
  shape: MaterialStateProperty.all<OutlinedBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  ),
);

final ButtonStyle defaultButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(BTN_COLOR),
  shape: MaterialStateProperty.all<OutlinedBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  ),
);

final ButtonStyle selectedButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(PRIMARY_COLOR),
  shape: MaterialStateProperty.all<OutlinedBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  ),
);

final TextStyle disabledTextStyle =
    TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.3));

const TextStyle defaultTextStyle = TextStyle(fontSize: 13, color: Colors.white);

const TextStyle selectedTextStyle =
    TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold);
