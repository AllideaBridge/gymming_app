import 'package:flutter/material.dart';

import '../../colors.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final Function onPressed;

  const PrimaryButton(
      {super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: PRIMARY_COLOR,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          minimumSize: Size(160, 56)),
      onPressed: () {
        onPressed();
      },
      child: Text(
        title,
        style: TextStyle(
          color: INDICATOR_COLOR,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    ));
  }
}
