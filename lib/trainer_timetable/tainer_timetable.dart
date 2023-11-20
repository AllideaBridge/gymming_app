import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../common/constants.dart';
import '../state/state_date_time.dart';

class TrainerTimeTable extends StatefulWidget {
  const TrainerTimeTable({Key? key}) : super(key: key);

  @override
  State<TrainerTimeTable> createState() => _TrainerTimeTableState();
}

class _TrainerTimeTableState extends State<TrainerTimeTable> {

  @override
  Widget build(BuildContext context) {
    int year = Provider.of<StateDateTime>(context).selectedDateTime.year;
    int month = Provider.of<StateDateTime>(context).selectedDateTime.month;
    // int dayOfSunday = Provider.of<StateDateTime>(context).selectedDateTime.dayOfSunday;

    var lastDayOfMonth = year % 4 == 0 ? leapYear : notLeapYear;
    var monthArr = [];
    var dayArr = [];

    // for (int i = 0; i < 7; i++) {
    //   if (dayOfSunday + i > lastDayOfMonth[month - 1]) {
    //     monthArr.add(month + 1);
    //     dayArr.add(dayOfSunday + i - lastDayOfMonth[month - 1]);
    //   } else {
    //     monthArr.add(month);
    //     dayArr.add(dayOfSunday + i);
    //   }
    // }

    // return Container(
    //   margin: EdgeInsets.only(bottom: 80),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: [
    //       ScheduleDay(month: monthArr[0], day: dayArr[0], dayOfWeek: "SUN"),
    //       ScheduleDay(month: monthArr[1], day: dayArr[1], dayOfWeek: "MON"),
    //       ScheduleDay(month: monthArr[2], day: dayArr[2], dayOfWeek: "TUE"),
    //       ScheduleDay(month: monthArr[3], day: dayArr[3], dayOfWeek: "WED"),
    //       ScheduleDay(month: monthArr[4], day: dayArr[4], dayOfWeek: "THR"),
    //       ScheduleDay(month: monthArr[5], day: dayArr[5], dayOfWeek: "FRI"),
    //       ScheduleDay(month: monthArr[6], day: dayArr[6], dayOfWeek: "SAT")
    //     ],
    //   ),
    // );
    double gap = (MediaQuery.of(context).size.width - 64) / 7;
    print(Provider.of<StateDateTime>(context).selectedDateTime.weekday);
    print(gap);

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Timetable"),
        actions: [
          IconButton(
            onPressed: () {
              // 버튼이 탭될 때 실행할 코드
              print('Image Button Tapped!');
            },
            icon:
                Image.asset('assets/alarm.png'), // 프로젝트의 assets 폴더에 이미지를 넣어주세요.
          )
        ],
        backgroundColor: Colors.black,
      ),
      drawer: Drawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Stack(
          children: [
            Positioned(
                // left: 10,
                child: Opacity(
                  opacity: 0.5,
                  child: Container(
                    margin: EdgeInsets.only(left: (50* (Provider.of<StateDateTime>(context).selectedDateTime.weekday%7) + 22), top: 22),
                    width: 46,
                    decoration: BoxDecoration(
                      color: Colors.grey, // 컨테이너의 배경 색상
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0), // 왼쪽 상단 모서리 둥글게
                        topRight: Radius.circular(25.0), // 오른쪽 상단 모서리 둥글게
                      ),
                    ),
                    // color: Colors.grey,
                  ),
                )),
            Column(
              children: [
                _calendar(context),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: 25,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Stack(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                      height: 48,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          '$index',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   width: 8,
                                    // ),
                                    Expanded(
                                      child: Container(
                                        // margin: EdgeInsets.only(right: 28),
                                        height: 1.0, // 줄의 두께
                                        color: Colors.grey, // 줄의 색상
                                        // 다른 Container 설정
                                      ),
                                    )
                                  ],
                                ),
                                Positioned(
                                    top: 0,
                                    left: 20,
                                    // right: 24,
                                    child: Row(
                                      children: List.generate(
                                          7,
                                          (index) => Container(
                                                margin:
                                                    EdgeInsets.only(left: 5.0, right: 5.0, top: 2, bottom: 2),
                                                height: 44,
                                                width: 40,
                                                color: Color(0xFFCDFB60),
                                              )),
                                    ))
                              ],
                            ),
                          ],
                        );
                      }),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _calendar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: TableCalendar(
          focusedDay: Provider.of<StateDateTime>(context).selectedDateTime,
          firstDay: DateTime(1800),
          lastDay: DateTime(3000),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(color: Colors.transparent),
            weekendStyle: TextStyle(color: Colors.transparent),
          ),
          calendarFormat: CalendarFormat.week,
          // calendarStyle: const CalendarStyle(
          //     tablePadding: EdgeInsets.symmetric(horizontal: 32.0)),
          headerVisible: false,
          calendarBuilders: CalendarBuilders(
            todayBuilder: _isSameDate(
                    Provider.of<StateDateTime>(context).selectedDateTime,
                    DateTime.now())
                ? _selectedDayBuilder
                : _defaultDayBuilder,
            defaultBuilder: _defaultDayBuilder,
            selectedBuilder: _selectedDayBuilder,
          ),
          onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
            Provider.of<StateDateTime>(context, listen: false)
                .changeStateDate(selectedDay);
          },
          selectedDayPredicate: (DateTime day) =>
              Provider.of<StateDateTime>(context).selectedDateTime.year ==
                  day.year &&
              Provider.of<StateDateTime>(context).selectedDateTime.month ==
                  day.month &&
              Provider.of<StateDateTime>(context).selectedDateTime.day ==
                  day.day),
    );
  }

  bool _isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Widget _selectedDayBuilder(context, day, focusedDay) {
    return Container(
      // margin: EdgeInsets.only(left: 2, right: 2),
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        // color: Colors.white.withOpacity(0.6), shape: BoxShape.circle
        color: Colors.transparent, // 배경색은 투명하게
        border: Border.all(
          color: Colors.white, // 테두리 색상은 하얗게
          width: 1.0, // 테두리 두께
        ),
        borderRadius: BorderRadius.circular(25.0),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            DateFormat.E().format(day),
            // 요일을 숫자로 표시합니다 (1 = 월요일, ..., 7 = 일요일)
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)
                .copyWith(fontSize: 12.0),
          ),
          Text(
            '${day.month}.${day.day}', // 일자를 표시합니다.
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)
                .copyWith(fontSize: 12.0),
          ),
        ],
      ),
    );
  }

  Widget _defaultDayBuilder(context, day, focusedDay) {
    return Container(
      width: 45,
      height: 45,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            DateFormat.E().format(day),
            // 요일을 숫자로 표시합니다 (1 = 월요일, ..., 7 = 일요일)
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)
                .copyWith(fontSize: 12.0),
          ),
          Text(
            '${day.month}.${day.day}', // 일자를 표시합니다.
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)
                .copyWith(fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}
