import 'package:flutter/material.dart';
import 'package:gymming_app/common/colors.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarTraineeDetail extends StatefulWidget {
  final List<DateTime> lessonDay;

  const CalendarTraineeDetail({super.key, required this.lessonDay});

  @override
  State<CalendarTraineeDetail> createState() => _CalendarTraineeDetailState();
}

class _CalendarTraineeDetailState extends State<CalendarTraineeDetail> {
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    const defaultTextStyle = TextStyle(color: Colors.white);
    const whiteTextStyle = TextStyle(color: Colors.white);

    return TableCalendar(
      focusedDay: _selectedDay,
      firstDay: DateTime(1800),
      lastDay: DateTime(3000),
      calendarFormat: CalendarFormat.month,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        rightChevronIcon: Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),
        leftChevronIcon: Icon(
          Icons.arrow_back_ios,
          size: 16,
        ),
        titleCentered: true,
        titleTextStyle: const TextStyle(
            fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
        titleTextFormatter: (date, locale) =>
            "${DateFormat.M(locale).format(date)}월",
      ),
      calendarStyle: const CalendarStyle(
        defaultTextStyle: defaultTextStyle,
        weekendTextStyle: defaultTextStyle,
        outsideTextStyle: TextStyle(color: Colors.white24),
        tablePadding: EdgeInsets.all(4),
        isTodayHighlighted: false,
        selectedTextStyle: whiteTextStyle,
        selectedDecoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
      ),
      onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
        setState(() {
          this._selectedDay = selectedDay;
        });
      },
      eventLoader: _getEventList,
      selectedDayPredicate: (DateTime day) =>
          _selectedDay.year == day.year &&
          _selectedDay.month == day.month &&
          _selectedDay.day == day.day,
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, events) {
          if (events.contains('today')) {
            return Container(
              width: 4,
              margin: const EdgeInsets.only(bottom: 28),
              decoration: const BoxDecoration(
                  color: PRIMARY_COLOR, shape: BoxShape.circle),
            );
          }
          if (events.contains('lessonDay')) {
            return Container(
              width: 35,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6), shape: BoxShape.circle),
            );
          }
          return null;
        },
      ),
    );
  }

  List<String> _getEventList(DateTime day) {
    if (containsDateTime(widget.lessonDay, day)) {
      return ['lessonDay'];
    }
    if (isSameDay(day, DateTime.now())) {
      // print(day);
      return ['today'];
    }
    return [];
  }

  bool containsDateTime(List<DateTime> dateList, DateTime targetDateTime) {
    for (DateTime date in dateList) {
      if (isSameDay(date, targetDateTime)) {
        return true;
      }
    }
    return false;
  }
}
