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
  var times = [];

  String selectedTime = '';
  String endTime = '';

  void onPressedTimeButton(String newTime) {
    // 30분 후의 시간도 available한지 확인해야 한다.
    // newTime 의 형식은 00:00 형태
    String selectedHour = newTime.split(":")[0];
    String selectedMinute = newTime.split(":")[1];
    // 30분 추가된 시간의 문자열 구하기
    if (selectedMinute == "30") {
      endTime = "${int.parse(selectedHour) + 1}:00";
    } else {
      endTime = "$selectedHour:30";
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
            onPressedTimeButton(newTime);
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
