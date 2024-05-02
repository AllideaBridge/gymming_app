import 'package:flutter/material.dart';
import 'package:gymming_app/services/models/available_times.dart';

import '../../../../common/colors.dart';

class GymbieSelectTime extends StatefulWidget {
  const GymbieSelectTime(
      {super.key,
      required this.selectedDay,
      required this.changeSelectedTime,
      required this.availableTimesList});

  final DateTime selectedDay;
  final Function(String) changeSelectedTime;
  final List<AvailableTimes> availableTimesList;

  @override
  State<GymbieSelectTime> createState() => _GymbieSelectTimeState();
}

class _GymbieSelectTimeState extends State<GymbieSelectTime> {
  var times = [];

  String selectedTime = '';

  void onPressedTimeButton(String newTime) {
    setState(() {
      selectedTime = newTime;
    });
    widget.changeSelectedTime(newTime);
  }

  @override
  void didUpdateWidget(GymbieSelectTime oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDay != oldWidget.selectedDay) {
      selectedTime = '';
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
              times[index].time == selectedTime,
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
