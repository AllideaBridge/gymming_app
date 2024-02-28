import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gymming_app/state/state_date_time.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  Set<dynamic> _isScheduled = {};
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    fetchData(now.year, now.month);
  }

  Future<void> fetchData(int year, int month) async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:5000/schedules/1/$year/$month'));
    if (response.statusCode == 200) {
      setState(() {
        _isScheduled =
            json.decode(response.body).map((item) => item.toString()).toSet();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    const defaultTextStyle = TextStyle(color: Colors.white);
    return TableCalendar(
      focusedDay: Provider.of<StateDateTime>(context).selectedDateTime,
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
        Provider.of<StateDateTime>(context, listen: false)
            .changeStateDate(selectedDay);
      },
      eventLoader: _getEventList,
      calendarBuilders: CalendarBuilders(markerBuilder: (context, date, event) {
        if (event.isNotEmpty) {
          return Container(
            width: 35,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6), shape: BoxShape.circle),
          );
        }
        return null;
      }),
      selectedDayPredicate: (DateTime day) =>
          Provider.of<StateDateTime>(context).selectedDateTime.year ==
              day.year &&
          Provider.of<StateDateTime>(context).selectedDateTime.month ==
              day.month &&
          Provider.of<StateDateTime>(context).selectedDateTime.day == day.day,
      onPageChanged: (DateTime day) {
        Provider.of<StateDateTime>(context, listen: false).changeStateDate(day);
        setState(() {
          fetchData(day.year, day.month);
        });
      },
    );
  }

  List<bool> _getEventList(DateTime day) {
    if (_isScheduled.contains(
        "${day.year}-${day.month < 10 ? "0" : ""}${day.month}-${day.day < 10 ? "0" : ""}${day.day}")) {
      return [true];
    }
    return [];
  }
}
