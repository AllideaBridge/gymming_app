import 'package:flutter/material.dart';

import '../../common/colors.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final bool enabled;

  const PrimaryButton(
      {super.key,
      required this.title,
      required this.onPressed,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor:
              enabled ? PRIMARY_COLOR : PRIMARY_COLOR.withOpacity(0.3),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          minimumSize: Size(160, 56)),
      onPressed: () {
        if (enabled) {
          onPressed();
        } else {
          null;
        }
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
