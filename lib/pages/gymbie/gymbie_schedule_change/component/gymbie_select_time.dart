import 'package:flutter/material.dart';

import '../../../../common/colors.dart';

class GymbieSelectTime extends StatefulWidget {
  const GymbieSelectTime(
      {super.key, required this.selectedDay, required this.changeSelectedTime});

  final DateTime selectedDay;
  final Function(String) changeSelectedTime;

  @override
  State<GymbieSelectTime> createState() => _GymbieSelectTimeState();
}

class _GymbieSelectTimeState extends State<GymbieSelectTime> {
  final List<Time> times = [
    Time(time: '06:00', isPossible: false),
    Time(time: '07:00', isPossible: false),
    Time(time: '08:00', isPossible: false),
    Time(time: '09:00', isPossible: true),
    Time(time: '10:00', isPossible: true),
    Time(time: '11:00', isPossible: true),
    Time(time: '12:00', isPossible: true),
    Time(time: '13:00', isPossible: true),
    Time(time: '14:00', isPossible: true),
    Time(time: '15:00', isPossible: false),
    Time(time: '16:00', isPossible: true),
    Time(time: '17:00', isPossible: true),
    Time(time: '18:00', isPossible: false),
    Time(time: '19:00', isPossible: false),
    Time(time: '20:00', isPossible: true),
    Time(time: '21:00', isPossible: true),
    Time(time: '22:00', isPossible: false),
    Time(time: '23:00', isPossible: false)
  ];

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
    // selectedDay 변수가 변경될 때 실행되는 로직을 여기에 추가
    if (widget.selectedDay != oldWidget.selectedDay) {
      // selectedDay가 변경된 경우, 원하는 동작 수행
      // 예를 들어, 기본 시간을 리셋하거나 다른 작업 수행 가능
      selectedTime = ''; // 예시: 기본 시간 리셋
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
    TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.3));

const TextStyle defaultTextStyle = TextStyle(fontSize: 14, color: Colors.white);

const TextStyle selectedTextStyle =
    TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold);

class Time {
  String time;
  bool isPossible;

  Time({required this.time, required this.isPossible});
}
