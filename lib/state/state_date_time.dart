import 'package:flutter/material.dart';

class StateDateTime with ChangeNotifier {
  DateTime selectedDateTime;

  StateDateTime({required this.selectedDateTime});

  void changeStateDate(DateTime selectedDateTime) {
    if (this.selectedDateTime.isAtSameMomentAs(selectedDateTime)) {
      return;
    }
    this.selectedDateTime = selectedDateTime;
    notifyListeners();
  }
}
