import 'dart:ui';

import 'package:gymming_app/services/models/lesson_list.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class LessonDataSource extends CalendarDataSource {
  LessonDataSource(List<LessonList> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].name;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }
}
