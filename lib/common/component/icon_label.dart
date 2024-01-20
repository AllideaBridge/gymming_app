import 'package:flutter/material.dart';

import '../colors.dart';

class IconLabel extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Color titleColor;
  final String content;
  final Color contentColor;

  const IconLabel(
      {super.key,
      required this.iconData,
      required this.title,
      required this.content,
      required this.titleColor,
      required this.contentColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          iconData,
          color: SECONDARY_COLOR,
          size: 20,
        ),
        SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: titleColor, fontSize: 18),
            ),
            Text(
              content,
              style: TextStyle(
                  color: contentColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            )
          ],
        )
      ],
    );
  }
}
