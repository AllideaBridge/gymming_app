import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../common/constants.dart';
import '../../state/state_week.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    const defaultTextStyle = TextStyle(color: Colors.white);
    return TableCalendar(
      focusedDay: selectedDay,
      firstDay: DateTime(1800),
      lastDay: DateTime(3000),
      calendarFormat: CalendarFormat.month,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        rightChevronVisible: false,
        leftChevronVisible: false,
        headerPadding: const EdgeInsets.all(8),
        titleTextStyle:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        titleTextFormatter: (date, locale) =>
            "${date.year % 100} ${DateFormat.MMMM(locale).format(date).toUpperCase()}",
      ),
      calendarStyle: const CalendarStyle(
        defaultTextStyle: defaultTextStyle,
        weekendTextStyle: defaultTextStyle,
        outsideTextStyle: TextStyle(color: Colors.white24),
        tablePadding: EdgeInsets.all(4),
      ),
      onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
        setState(() {
          this.selectedDay = selectedDay;
        });
        int year = this.selectedDay.year;
        int month = this.selectedDay.month;

        var lastDayOfMonth = year % 4 == 0 ? leapYear : notLeapYear;
        int dayOfSunday = selectedDay.weekday == 7
            ? selectedDay.day
            : selectedDay.day - selectedDay.weekday > 0
                ? selectedDay.day - selectedDay.weekday
                : lastDayOfMonth[--month - 1] +
                    selectedDay.day -
                    selectedDay.weekday;

        if (Provider.of<StateWeek>(context, listen: false)
            .isStateChanged(year, month, dayOfSunday)) {
          Provider.of<StateWeek>(context, listen: false)
              .changeStateWeek(year, month, dayOfSunday);
        }
      },
      selectedDayPredicate: (DateTime day) =>
          selectedDay.year == day.year &&
          selectedDay.month == day.month &&
          selectedDay.day == day.day,
    );
  }
}
