import 'package:flutter/material.dart';

class LoginFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '개인정보 처리 방침',
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
        SizedBox(
          width: 12,
        ),
        Container(
          width: 1,
          height: 12,
          color: Colors.white,
        ),
        SizedBox(
          width: 12,
        ),
        Text(
          '이용 약관',
          style: TextStyle(fontSize: 12, color: Colors.white),
        )
      ],
    );
  }
}
