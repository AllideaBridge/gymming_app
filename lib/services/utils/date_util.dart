import 'package:intl/intl.dart';

const LEAP_YEAR = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
const NOT_LEAP_YEAR = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

class DateUtil {
  static List<int> lastDayOfMonths(int year) {
    return year % 4 == 0 ? LEAP_YEAR : NOT_LEAP_YEAR;
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

  static String convertKoreanWithoutWeek(DateTime dateTime) {
    String hour =
        dateTime.hour < 10 ? '0${dateTime.hour}' : dateTime.hour.toString();
    String minute = dateTime.minute < 10
        ? '0${dateTime.minute}'
        : dateTime.minute.toString();
    return '${dateTime.month}월 ${dateTime.day}일 $hour:$minute';
  }

  static String convertDateTimeWithDot(DateTime dateTime) {
    String day = dateTime.day.toString().padLeft(2, '0');
    String month = dateTime.month.toString().padLeft(2, '0');
    String year = dateTime.year.toString().substring(2); // 뒤 두 자리만 사용
    String hour = dateTime.hour.toString().padLeft(2, '0');
    String minute = dateTime.minute.toString().padLeft(2, '0');

    return '$year.$month.$day. $hour:$minute';
  }

  static String convertDateTimeWithDash(DateTime day) {
    return DateFormat("yyyy-MM-dd").format(day);
  }

  static String convertDatabaseFormatFromDayAndTime(DateTime day, String time) {
    var dateTime = DateTime(
      day.year,
      day.month,
      day.day,
      DateFormat('HH:mm').parse(time).hour,
      DateFormat('HH:mm').parse(time).minute,
    );
    return dateTime.toString();
  }

  static bool isTodayInDateList(List<DateTime> dates) {
    for (DateTime date in dates) {
      if (isSameDate(date, DateTime.now())) {
        return true;
      }
    }
    return false;
  }
}
