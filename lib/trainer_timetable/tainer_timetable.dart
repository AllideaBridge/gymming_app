import 'package:flutter/material.dart';
import 'package:gymming_app/user_timetable/user_timetable.dart';

import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../common/constants.dart';
import '../common/component/request.dart';
import '../user_management/user_management_list.dart';

class TrainerTimeTable extends StatefulWidget {
  const TrainerTimeTable({Key? key}) : super(key: key);

  @override
  State<TrainerTimeTable> createState() => _TrainerTimeTableState();
}

class _TrainerTimeTableState extends State<TrainerTimeTable> {
  late int diffFromNow;
  late DateTime nowFocusedDate;

  bool needFocus = false;
  late int focusIdx;

  @override
  void initState() {
    super.initState();
    diffFromNow = 0;
    nowFocusedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    double hourComponentHeight = 48;

    // 이름, 시작, 종료 시간, 요일

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
      drawer: Drawer(
          child: ListView(
        // 주요 내비게이션 항목들
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('회원 관리'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Request(
                            title: "회원 관리",
                            leftTabName: "현재 등록 회원",
                            rightTabName: "이전 등록 회원",
                            leftComponent: UserManagementList(),
                            rightComponent: UserManagementList(),
                          )));
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // 다른 작업
              Navigator.pop(context); // 드로어를 닫습니다.
            },
          ),
          // ... 다른 리스트 타일 항목들 ...
        ],
      )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Stack(
          children: [
            if (diffFromNow == 0)
              Positioned(
                  child: Opacity(
                opacity: 0.5,
                child: Container(
                  margin: EdgeInsets.only(
                      left: (50 * (DateTime.now().weekday % 7) + 22), top: 20),
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
                  height: SIZE20,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      ListView.builder(
                          itemCount: 25,
                          itemBuilder: (context, index) {
                            return Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                      height: hourComponentHeight,
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          '$index',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(top: 8),
                                        height: 1.0, // 줄의 두께
                                        color: Colors.grey, // 줄의 색상
                                        // 다른 Container 설정
                                      ),
                                    )
                                  ],
                                ),
                                if (index == 2)
                                  Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 30.0, right: 5.0),
                                        height: 60,
                                        width: 40,
                                        // color: Color(0xFFCDFB60),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFCDFB60),
                                        ),
                                        child: GestureDetector(
                                            onTap: () {
                                              print("haha");
                                            },
                                            child: Text("PT")),
                                      )
                                    ],
                                  ),
                                // if (index == 2)
                                //   Positioned(
                                //       top: -42,
                                //       left: 20,
                                //       // right: 24,
                                //       child: Container(
                                //         margin: EdgeInsets.only(
                                //             left: 5.0, right: 5.0),
                                //         height: 72,
                                //         width: 40,
                                //         // color: Color(0xFFCDFB60),
                                //         decoration: BoxDecoration(
                                //           color: Color(0xFFCDFB60),
                                //         ),
                                //         child: GestureDetector(
                                //             onTap: () {
                                //               print("haha");
                                //             },
                                //             child: Text("PT")),
                                //       )),
                                if (diffFromNow == 0 &&
                                    DateTime.now()
                                            .add(Duration(hours: 9))
                                            .hour ==
                                        index)
                                  Positioned(
                                      top: 8 +
                                          (DateTime.now().minute / 60.0) *
                                              hourComponentHeight,
                                      left: 50 * (DateTime.now().weekday % 7) +
                                          22,
                                      child: Container(
                                        width: 45,
                                        height: 4,
                                        color: Colors.white,
                                      )),
                              ],
                            );
                          }),
                      // ListView.builder(
                      //     itemCount: 2,
                      //     itemBuilder:(context, index) {
                      //   return Container(
                      //     width: 0,
                      //     height: 10,
                      //     color: Color(0xFFCDFB60),
                      //   );
                      // })
                      // Positioned(
                      //     child: Container(
                      //   margin: EdgeInsets.only(left: 5.0, right: 5.0),
                      //   height: 48,
                      //   width: 40,
                      //   // color: Color(0xFFCDFB60),
                      //   decoration: BoxDecoration(
                      //     color: Color(0xFFCDFB60),
                      //   ),
                      // ))
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => UserTimeTable()));
        },
        backgroundColor: Colors.white54,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _calendar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: TableCalendar(
        onPageChanged: (DateTime focusedDay) {
          print("${focusedDay.month}/${focusedDay.day}");
          setState(() {
            // 과거, 미래
            nowFocusedDate.difference(focusedDay).inDays > 0
                ? diffFromNow--
                : diffFromNow++;
            nowFocusedDate = focusedDay;
          });
        },
        focusedDay: DateTime.now().add(Duration(days: 7 * diffFromNow)),
        firstDay: DateTime(1800),
        lastDay: DateTime(3000),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(color: Colors.transparent),
          weekendStyle: TextStyle(color: Colors.transparent),
        ),
        calendarFormat: CalendarFormat.week,
        headerVisible: false,
        calendarBuilders: CalendarBuilders(
            todayBuilder: _todayBuilder,
            defaultBuilder: _defaultDayBuilder,
            outsideBuilder: _defaultDayBuilder),
      ),
    );
  }

  Widget _todayBuilder(BuildContext context, DateTime day, focusedDay) {
    print("todayBuilder");
    // Future.delayed(Duration.zero, () {
    //   setState(() {
    //     needFocus = true;
    //   });
    // });

    needFocus = true;
    focusIdx = day.weekday;
    return Container(
      // margin: EdgeInsets.only(left: 2, right: 2),
      width: SIZE45,
      height: SIZE45,
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

  Widget _defaultDayBuilder(BuildContext context, DateTime day, focusedDay) {
    return Container(
      width: SIZE45,
      height: SIZE45,
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
