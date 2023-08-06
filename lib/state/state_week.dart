import 'package:flutter/material.dart';

class StateWeek with ChangeNotifier {
  int year;
  int month;
  int dayOfSunday;

  StateWeek(
      {required this.year, required this.month, required this.dayOfSunday});

  void changeStateWeek(int year, int month, int dayOfSunday) {
    this.year = year;
    this.month = month;
    this.dayOfSunday = dayOfSunday;
    notifyListeners();
  }

  bool isStateChanged(int year, int month, int dayOfSunday) {
    if (this.year != year ||
        this.month != month ||
        this.dayOfSunday != dayOfSunday) {
      return true;
    }
    return false;
  }

// ToDo : month 인덱스 문제
// int calculateDayOfSunday(DateTime date) {
//   var lastDayOfMonths = year % 4 == 0 ? leapYear : notLeapYear;
//   if (date.weekday == 7) {
//     return date.day;
//   }
//
//   if (date.day - date.weekday > 0) {
//     return date.day - date.weekday;
//   }
//
//   //if()
// }
}
