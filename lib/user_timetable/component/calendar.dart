import 'package:flutter/material.dart';
import 'package:gymming_app/state/state_date_time.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late Set<String> _isScheduled;

  @override
  void initState() {
    super.initState();
    // 한달 스케쥴 api 호출
    // 서버에서 리턴되는 값 : [1, 3, 5, 6, 7, 9, 11, 12, 13, 17, 20, 25, 30]
    // 수업이 있는 날짜.
    _isScheduled = {
      "20230901",
      "20230903",
      "20230905",
      "20230906",
      "20230907",
      "20230909",
      "20230911",
      "20230912",
      "20230913",
      "20230917",
      "20230920",
      "20230925",
      "20230930"
    };
  }

  @override
  Widget build(BuildContext context) {
    print(
        "${Provider
            .of<StateDateTime>(context)
            .selectedDateTime
            .year}년 ${Provider
            .of<StateDateTime>(context)
            .selectedDateTime
            .month}월 ${Provider
            .of<StateDateTime>(context)
            .selectedDateTime
            .day}일 ${Provider
            .of<StateDateTime>(context)
            .selectedDateTime
            .hour}시 ${Provider
            .of<StateDateTime>(context)
            .selectedDateTime
            .minute}분");

    const defaultTextStyle = TextStyle(color: Colors.white);
    return TableCalendar(
      focusedDay: Provider
          .of<StateDateTime>(context)
          .selectedDateTime,
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
        "${date.year % 100} ${DateFormat.MMMM(locale)
            .format(date)
            .toUpperCase()}",
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
      Provider
          .of<StateDateTime>(context)
          .selectedDateTime
          .year ==
          day.year &&
          Provider
              .of<StateDateTime>(context)
              .selectedDateTime
              .month ==
              day.month &&
          Provider
              .of<StateDateTime>(context)
              .selectedDateTime
              .day == day.day,
      onPageChanged: (DateTime day) {
        Provider.of<StateDateTime>(context, listen: false).changeStateDate(day);
        setState(() {
          //ToDO
          print("api호출");
        });
      },
    );
  }

  List<bool> _getEventList(DateTime day) {
    if (_isScheduled.contains(
        "${day.year}${day.month < 10 ? "0" : ""}${day.month}${day.day < 10
            ? "0"
            : ""}${day.day}")) {
      return [true];
    }
    return [];
  }
}
