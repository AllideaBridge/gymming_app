import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../common/colors.dart';

class ScheduleSelectCalendar extends StatefulWidget {
  const ScheduleSelectCalendar(
      {super.key, this.originDay, required this.changeSelectedDay});

  final DateTime? originDay;
  final Function(DateTime) changeSelectedDay;

  @override
  State<ScheduleSelectCalendar> createState() => _ScheduleSelectCalendarState();
}

class _ScheduleSelectCalendarState extends State<ScheduleSelectCalendar> {
  DateTime selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.originDay != null) {
      selectedDay = widget.originDay!.add(const Duration(days: 1));
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.changeSelectedDay(selectedDay);
    });
  }

  @override
  Widget build(BuildContext context) {
    const defaultTextStyle = TextStyle(color: Colors.white);
    const blackTextStyle = TextStyle(color: Colors.black);

    return TableCalendar(
      focusedDay: selectedDay,
      firstDay: DateTime(1800),
      lastDay: DateTime(3000),
      calendarFormat: CalendarFormat.month,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        rightChevronIcon: Image.asset(
          'assets/images/icon_nav_arrow_right.png',
          width: 16,
          height: 16,
        ),
        leftChevronIcon: Image.asset(
          'assets/images/icon_nav_arrow_left.png',
          width: 16,
          height: 16,
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
          selectedTextStyle: blackTextStyle,
          selectedDecoration: BoxDecoration(
            color: PRIMARY_COLOR,
            shape: BoxShape.circle,
          )),
      onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
        var today = DateTime.now();
        if (selectedDay
            .isBefore(DateTime(today.year, today.month, today.day))) {
          return;
        }
        setState(() {
          this.selectedDay = selectedDay;
        });
        widget.changeSelectedDay(selectedDay);
      },
      eventLoader: _getEventList,
      selectedDayPredicate: (DateTime day) =>
          selectedDay.year == day.year &&
          selectedDay.month == day.month &&
          selectedDay.day == day.day,
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
          if (events.contains('originDay')) {
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
    if ((widget.originDay != null) && isSameDay(day, widget.originDay)) {
      return ['originDay'];
    }
    if (isSameDay(day, DateTime.now())) {
      return ['today'];
    }
    return [];
  }
}
