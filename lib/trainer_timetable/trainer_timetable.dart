import 'package:flutter/material.dart';
import 'package:gymming_app/user_timetable/user_timetable.dart';

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
    nowFocusedDate = DateTime.now()
        .subtract(Duration(days: DateTime.now().weekday))
        .add(Duration(days: 7 * diffFromNow));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white),
        title: const Text("Timetable"),
        actions: [
          IconButton(
            onPressed: () {
              print('Image Button Tapped!');
            },
            icon: Image.asset('assets/alarm.png'),
          )
        ],
        backgroundColor: Colors.black,
      ),
      drawer: Drawer(
          child: ListView(
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
              Navigator.pop(context);
            },
          ),
        ],
      )),
      body: Container(
          // child: SfCalendar(
          //   view: CalendarView.week,
          // ),
          ),
      //TODO: 나중에 제거
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
}
