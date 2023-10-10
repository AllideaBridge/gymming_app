import 'package:flutter/material.dart';
import 'package:gymming_app/common/colors.dart';
import 'package:gymming_app/user_timetable/component/calendar_modal.dart';

class ScheduleChange extends StatelessWidget {
  const ScheduleChange({super.key, required this.originDay});

  final DateTime originDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: BACKGROUND_COLOR,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Image.asset(
              'assets/icon_nav_arrow_left.png',
              height: 24,
              width: 24,
            ),
            const Text('일정 변경',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              width: 24,
              height: 24,
            ),
          ]),
          const SizedBox(
            height: 40,
          ),
          CalendarModal(originDay: originDay),
          const SizedBox(
            height: 40,
          ),
          Text('시간'),
          const SizedBox(
            height: 40,
          ),
          Text('버튼'),
        ],
      ),
    );
  }
}
