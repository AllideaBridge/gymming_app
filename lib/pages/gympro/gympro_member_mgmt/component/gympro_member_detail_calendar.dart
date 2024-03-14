import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../common/colors.dart';
import '../../../../components/icon_label.dart';
import '../../../../services/utils/date_util.dart';

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
      onDaySelected: (selectedDay, _) {
        setState(() {
          _selectedDay = selectedDay;
        });
        // TODO: 클릭한 날의 레슨 정보 가져오는 API 호출
        if (containsDateTime(widget.lessonDay, selectedDay)) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: false,
            builder: (BuildContext context) {
              return Wrap(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 8, 20, 40),
                    color: BACKGROUND_COLOR,
                    child: ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                                child: Container(
                              width: 60,
                              height: 6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: BTN_COLOR,
                              ),
                            )),
                            SizedBox(height: 28),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                // TODO: 레슨 상태에 따라 색상 변경
                                color: PRIMARY2_COLOR,
                              ),
                              // TODO: 레슨 상태에 따라 내용 변경
                              child: Text(
                                '정상 출석',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 28),
                            IconLabel(
                              iconData: Icons.alarm,
                              title: "일시",
                              // TODO: API를 통해서 받아오기
                              content:
                                  DateUtil.getKoreanDayAndHour(selectedDay),
                              titleColor: SECONDARY_COLOR,
                              contentColor: Colors.white,
                            ),
                            SizedBox(height: 28),
                            IconLabel(
                              iconData: Icons.location_on_outlined,
                              title: "장소",
                              // TODO: API를 통해서 받아오기
                              content: 'GYMGYM | 방이동',
                              titleColor: SECONDARY_COLOR,
                              contentColor: Colors.white,
                            ),
                          ],
                        )),
                  ),
                ],
              );
            },
          );
        }
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
