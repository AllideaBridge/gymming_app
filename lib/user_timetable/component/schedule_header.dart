import 'package:flutter/material.dart';

class ScheduleHeader extends StatelessWidget {
  final String type;

  const ScheduleHeader({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      IconButton(
        icon: Image.asset(
          'assets/icon_nav_arrow_left.png',
          height: 24,
          width: 24,
        ),
        onPressed: () {
          // 뒤로 가기 동작 또는 다른 작업을 수행
          Navigator.of(context).pop();
        },
      ),
      Text('일정 $type',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
      const SizedBox(
        width: 24,
        height: 24,
      ),
    ]);
  }
}
