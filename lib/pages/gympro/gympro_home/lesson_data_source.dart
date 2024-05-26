import 'package:flutter/material.dart';
import 'package:gymming_app/common/colors.dart';
import 'package:gymming_app/services/models/lesson_list.dart';
import 'package:gymming_app/services/models/meeting.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class LessonDataSource extends CalendarDataSource {
  LessonDataSource(List<LessonList> source) {
    List<Meeting> meetings = [];
    for (LessonList lessonList in source) {
      meetings.add(Meeting.fromLessonList(lessonList, PRIMARY_COLOR));
    }
    appointments = meetings;
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
