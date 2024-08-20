import 'package:flutter/material.dart';
import 'package:gymming_app/components/state_date_time.dart';
import 'package:gymming_app/services/models/schedule_detail.dart';
import 'package:gymming_app/services/models/schedule_trainer_user.dart';
import 'package:gymming_app/services/repositories/schedule_repository.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../common/colors.dart';
import '../../../../components/icon_label.dart';
import '../../../../services/utils/date_util.dart';

class GymproMemberDetailCalendar extends StatefulWidget {
  final int trainerId;
  final int userId;

  const GymproMemberDetailCalendar(
      {Key? key, required this.trainerId, required this.userId})
      : super(key: key);

  @override
  State<GymproMemberDetailCalendar> createState() =>
      _GymproMemberDetailCalendarState();
}

class _GymproMemberDetailCalendarState
    extends State<GymproMemberDetailCalendar> {
  final scheduleRepository = ScheduleRepository(client: http.Client());
  late Future<Set<ScheduleTrainerUser>> futureSchedules;

  @override
  void initState() {
    super.initState();
    futureSchedules = scheduleRepository.getTrainerUserScheduleByMonth(
        widget.trainerId, widget.userId, DateUtil.getKorTimeNow());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 28.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '수업 진행 이력',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: SECONDARY_COLOR,
            ),
          ),
          SizedBox(height: 20),
          FutureBuilder(
              future: futureSchedules,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final schedules = snapshot.data!;
                  return buildCalendar(schedules);
                } else if (snapshot.hasError) {
                  return Text(
                    "${snapshot.error}",
                    style: TextStyle(color: Colors.white),
                  );
                }

                return const CircularProgressIndicator();
              })
        ],
      ),
    );
  }

  Widget buildCalendar(Set<ScheduleTrainerUser> schedules) {
    const defaultTextStyle = TextStyle(color: Colors.white);
    const whiteTextStyle = TextStyle(color: Colors.white);

    List<String> getEventList(DateTime day) {
      if (containsDateTime(schedules, day)) {
        return ['lessonDay'];
      }
      if (isSameDay(day, DateUtil.getKorTimeNow())) {
        return ['today'];
      }
      return [];
    }

    return TableCalendar(
      focusedDay: Provider.of<StateDateTime>(context).selectedDateTime,
      firstDay: DateTime(1800),
      lastDay: DateTime(3000),
      calendarFormat: CalendarFormat.month,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        rightChevronIcon: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.white,
        ),
        leftChevronIcon: Icon(
          Icons.arrow_back_ios,
          size: 16,
          color: Colors.white,
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
      onDaySelected: (DateTime selectedDay, _) async {
        Provider.of<StateDateTime>(context, listen: false)
            .changeStateDate(selectedDay);

        var scheduleId = findScheduleId(schedules, selectedDay);
        if (scheduleId != -1) {
          ScheduleDetail scheduleDetail =
              await scheduleRepository.getScheduleDetail(scheduleId);
          buildBottomSheet(scheduleDetail);
        }
      },
      eventLoader: getEventList,
      selectedDayPredicate: (DateTime day) =>
          Provider.of<StateDateTime>(context).selectedDateTime.year ==
              day.year &&
          Provider.of<StateDateTime>(context).selectedDateTime.month ==
              day.month &&
          Provider.of<StateDateTime>(context).selectedDateTime.day == day.day,
      onPageChanged: (DateTime day) {
        Provider.of<StateDateTime>(context, listen: false).changeStateDate(day);
        setState(() {
          futureSchedules = scheduleRepository.getTrainerUserScheduleByMonth(
              widget.trainerId, widget.userId, day);
        });
      },
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

  void buildBottomSheet(ScheduleDetail scheduleDetail) {
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
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
                    IconLabel(
                      iconData: Icons.alarm,
                      title: "일시",
                      content: DateUtil.getKoreanDayAndHour(
                          scheduleDetail.startTime),
                      titleColor: SECONDARY_COLOR,
                      contentColor: Colors.white,
                    ),
                    SizedBox(height: 28),
                    IconLabel(
                      iconData: Icons.location_on_outlined,
                      title: "장소",
                      content:
                          '${scheduleDetail.centerName} | ${scheduleDetail.centerLocation}',
                      titleColor: SECONDARY_COLOR,
                      contentColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  bool containsDateTime(
      Set<ScheduleTrainerUser> scheduleList, DateTime targetDateTime) {
    for (var schedule in scheduleList) {
      {
        if (schedule.startTime.year == targetDateTime.year &&
            schedule.startTime.month == targetDateTime.month &&
            schedule.startTime.day == targetDateTime.day) {
          return true;
        }
      }
    }
    return false;
  }

  int findScheduleId(
      Set<ScheduleTrainerUser> scheduleList, DateTime targetDateTime) {
    for (var schedule in scheduleList) {
      {
        if (schedule.startTime.year == targetDateTime.year &&
            schedule.startTime.month == targetDateTime.month &&
            schedule.startTime.day == targetDateTime.day) {
          return schedule.scheduleId;
        }
      }
    }
    return -1;
  }
}
