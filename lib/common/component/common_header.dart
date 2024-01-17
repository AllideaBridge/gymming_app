import 'package:flutter/material.dart';

class CommonHeader extends StatelessWidget {
  final String title;

  const CommonHeader({super.key, required this.title});

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
      Text(title,
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
      const SizedBox(
        width: 24,
        height: 24,
      ),
    ]);
  }
}
