import '../constants.dart';

class DateUtil {
  static List<int> lastDayOfMonths(int year) {
    return year % 4 == 0 ? leapYear : notLeapYear;
  }
}
