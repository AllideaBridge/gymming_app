import '../constants.dart';

class DateUtil {
  static List<int> lastDayOfMonths(int year) {
    return year % 4 == 0 ? leapYear : notLeapYear;
  }

  static String getKoreanWeekDay(DateTime day) {
    List<String> weekDays = ['일', '월', '화', '수', '목', '금', '토'];
    return weekDays[day.weekday];
  }

  static String getKoreanDayAndHour(DateTime day) {
    String hour = day.hour < 10 ? '0${day.hour}' : day.hour.toString();
    return '${day.month}월 ${day.day}일 ${getKoreanWeekDay(day)}요일 $hour:00';
  }

  static String getKoreanDayAndExactHour(DateTime day, String hour) {
    return '${day.month}월 ${day.day}일 ${getKoreanWeekDay(day)}요일 $hour';
  }
}
