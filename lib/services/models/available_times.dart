import 'package:intl/intl.dart';

class AvailableTimes {
  final String availabilityEndTime;
  final String availabilityStartTime;
  final int lessonMinutes;
  final int lessonChangeRange;
  final List<Map<String, dynamic>> schedules;

  AvailableTimes({
    required this.availabilityEndTime,
    required this.availabilityStartTime,
    required this.lessonMinutes,
    required this.lessonChangeRange,
    required this.schedules,
  });

  factory AvailableTimes.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>> convertedSchedules =
        (json['schedules'] as List<dynamic>).cast<Map<String, dynamic>>();

    return AvailableTimes(
      availabilityEndTime: json['availability_end_time'],
      availabilityStartTime: json['availability_start_time'],
      lessonMinutes: json['lesson_minutes'],
      lessonChangeRange: json['lesson_change_range'],
      schedules: convertedSchedules,
    );
  }

  // List<String> generateTimeSlots(String startTime, String endTime) {
  //   List<String> timeSlots = [];
  //
  //   // startTime을 시간과 분으로 분리
  //   List<String> startTimeParts = startTime.split(':');
  //   int startHour = int.parse(startTimeParts[0]);
  //   int startMinute = int.parse(startTimeParts[1]);
  //
  //   // endTime을 시간과 분으로 분리
  //   List<String> endTimeParts = endTime.split(':');
  //   int endHour = int.parse(endTimeParts[0]);
  //   int endMinute = int.parse(endTimeParts[1]);
  //
  //   // 시작 시간과 종료 시간을 DateTime으로 변환
  //   DateTime startDateTime = DateTime(2024, 1, 1, startHour, startMinute);
  //   DateTime endDateTime = DateTime(2024, 1, 1, endHour, endMinute);
  //
  //   // 30분 간격으로 시간 슬롯 생성
  //   while (startDateTime.isBefore(endDateTime)) {
  //     String formattedTime =
  //         '${startDateTime.hour.toString().padLeft(2, '0')}:${startDateTime.minute.toString().padLeft(2, '0')}';
  //     timeSlots.add(formattedTime);
  //     startDateTime = startDateTime.add(Duration(minutes: 30));
  //   }
  //
  //   return timeSlots;
  // }

  List<Time> generateTimeSlots() {
    final defaultFormat = DateFormat('HH:mm');

    DateTime startTime = defaultFormat.parse(availabilityStartTime);
    DateTime endTime = availabilityEndTime == '00:00'
        ? defaultFormat.parse(availabilityEndTime).add(Duration(days: 1))
        : defaultFormat.parse(availabilityEndTime);
    List<Time> timeSlots = [];

    while (startTime.isBefore(endTime)) {
      var isPossible = true;
      for (var i = 0; i < schedules.length; i++) {
        final fullDateFormat = DateFormat("E, d MMM yyyy HH:mm:ss 'GMT'");

        final schedule = schedules[i];

        final startNumber = startTime.hour * 60 + startTime.minute;
        final scheduleStartTime =
            fullDateFormat.parse(schedule['schedule_start_time']);
        final scheduleStartNumber =
            scheduleStartTime.hour * 60 + scheduleStartTime.minute;
        final scheduleEndNumber = scheduleStartNumber + lessonMinutes;

        if (startNumber >= scheduleStartNumber &&
            startNumber < scheduleEndNumber) {
          isPossible = false;
          break;
        }
      }
      timeSlots.add(
          Time(time: defaultFormat.format(startTime), isPossible: isPossible));
      startTime = startTime.add(Duration(minutes: 30));
    }
    return timeSlots;
  }
}

class Time {
  String time;
  bool isPossible;

  Time({required this.time, required this.isPossible});
}
