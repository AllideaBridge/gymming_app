import 'package:flutter/material.dart';

import '../../common/colors.dart';

class SecondaryButton extends StatelessWidget {
  final String title;
  final Function onPressed;

  const SecondaryButton(
      {super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: BTN_COLOR,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          minimumSize: const Size.fromHeight(56)),
      onPressed: () {
        onPressed();
      },
      child: Text(
        title,
        style: TextStyle(
          color: PRIMARY_COLOR,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
