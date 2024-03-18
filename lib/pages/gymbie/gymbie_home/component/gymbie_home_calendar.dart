import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gymming_app/components/state_date_time.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class GymbieHomeCalendar extends StatefulWidget {
  const GymbieHomeCalendar({Key? key}) : super(key: key);

  @override
  State<GymbieHomeCalendar> createState() => _GymbieHomeCalendarState();
}

class _GymbieHomeCalendarState extends State<GymbieHomeCalendar> {

  late Future<Set<String>> futureSchedules;

  @override
  void initState() {
    super.initState();
    futureSchedules = fetchScheduleList(DateTime.now().year, DateTime.now().month);
  }

  Future<Set<String>> fetchScheduleList(int year, int month) async {
    var url = Uri.parse('http://10.0.2.2:5000/schedules/1/$year/$month');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List body = json.decode(response.body);
      return body.map((item) => item.toString()).toSet();
    } else {
      throw Exception("failed to load album");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureSchedules,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final schedules = snapshot.data!;
            return buildCalendar(schedules);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return const CircularProgressIndicator();
        });
  }

  Widget buildCalendar(Set<dynamic> schedules) {
    //event loader 용 함수
    List<bool> getScheduleEvents(DateTime day) {
      if (schedules.contains(
          "${day.year}-${day.month < 10 ? "0" : ""}${day.month}-${day.day < 10
              ? "0"
              : ""}${day.day}")) {
        return [true];
      }
      return [];
    }

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
      eventLoader: getScheduleEvents,
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
          futureSchedules =  fetchScheduleList(day.year, day.month);
        });
      },
    );
  }
}
