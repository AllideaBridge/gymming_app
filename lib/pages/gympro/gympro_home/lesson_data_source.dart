import 'package:gymming_app/common/colors.dart';
import 'package:gymming_app/services/models/lesson_list.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class LessonDataSource extends CalendarDataSource {
  LessonDataSource(List<LessonList> source) {
    List<Appointment> _appointments = <Appointment>[];
    for (LessonList lessonList in source) {
      Appointment appointment = Appointment(
          startTime: lessonList.startTime,
          endTime: lessonList.startTime
              .add(Duration(minutes: lessonList.lessonMinute)),
          subject: lessonList.userName,
          color: PRIMARY_COLOR);
      _appointments.add(appointment);
    }
    appointments = _appointments;
  }
}
