import 'package:flutter/material.dart';

import '../colors.dart';

class ToastUtil {
  static Widget defaultToast(String msg) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: BACKGROUND_COLOR,
      ),
      child: Text(
        msg,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );

    return toast;
  }
}
