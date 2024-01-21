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

  static String getKoreanWeekDay(DateTime day) {
    List<String> weekDays = ['일', '월', '화', '수', '목', '금', '토'];
    return weekDays[day.weekday % 7];
  }

  static String getKoreanDayAndHour(DateTime? day) {
    if (day == null) return '';
    String hour = day.hour < 10 ? '0${day.hour}' : day.hour.toString();
    return '${day.month}월 ${day.day}일 ${getKoreanWeekDay(day)}요일 $hour:00';
  }

  static String getKoreanDay(DateTime? day) {
    if (day == null) return '';
    return '${day.month}월 ${day.day}일 ${getKoreanWeekDay(day)}요일 ';
  }

  static String getKoreanDayAndExactHour(DateTime? day, String? hour) {
    if (day == null || hour == null) return '';
    return '${day.month}월 ${day.day}일 ${getKoreanWeekDay(day)}요일 $hour';
  }
}
