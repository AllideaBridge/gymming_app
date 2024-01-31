import 'package:flutter/material.dart';

import '../../colors.dart';

class PrimaryChip extends StatelessWidget {
  final String title;

  const PrimaryChip({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32.0,
      height: 20.0,
      decoration: BoxDecoration(
        color: PRIMARY_COLOR,
        borderRadius: BorderRadius.circular(4.0),
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(fontSize: 12),
      ),
    );
  }
}
