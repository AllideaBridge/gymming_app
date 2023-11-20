import 'package:flutter/material.dart';
import 'package:gymming_app/user_request/request.dart';
import 'package:gymming_app/explore/explore_main.dart';
import 'package:gymming_app/user_timetable/component/calendar.dart';
import 'package:gymming_app/user_timetable/component/schedule_list.dart';

class UserTimeTable extends StatelessWidget {
  const UserTimeTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Timetable"),
        actions: [
          TextButton(
            style: ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(Colors.white)),
            child: Text('둘러보기'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ExploreScreen()));
            },
          ),
          Image.asset('assets/arrow.png')
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
              title: Text('요청'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Request()));
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // 다른 작업
                Navigator.pop(context);  // 드로어를 닫습니다.
              },
            ),
            // ... 다른 리스트 타일 항목들 ...
          ],
        ),
      ),
      body: Column(
        children: [Calendar(), ScheduleList()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white54,
        child: Icon(Icons.add),
      ),
    );
  }
}
