import 'dart:ui';

import 'package:gymming_app/services/models/lesson_list.dart';

class Meeting {
  Meeting(this.name, this.from, this.to, this.background, this.isAllDay);

  String name;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;

  factory Meeting.fromLessonList(LessonList lessonList, Color background) {
    DateTime to =
        lessonList.startTime.add(Duration(minutes: lessonList.lessonMinute));
    return Meeting(
        lessonList.userName, lessonList.startTime, to, background, false);
  }
}
