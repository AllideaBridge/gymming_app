import '../constants.dart';

class DateUtil {
  static List<int> lastDayOfMonths(int year) {
    return year % 4 == 0 ? leapYear : notLeapYear;
  }

  static bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
