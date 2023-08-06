import 'package:flutter/material.dart';
import 'package:gymming_app/user_timetable/component/calendar.dart';

import 'component/schedule_week.dart';

class TimeTable extends StatelessWidget {
  const TimeTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Timetable"),
        actions: [
          const TextButton(
            onPressed: null,
            style: ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(Colors.white)),
            child: Text('둘러보기'),
          ),
          Image.asset('assets/arrow.png')
        ],
        backgroundColor: Colors.black,
      ),
      drawer: const Drawer(),
      body: ListView(
        children: [
          Calendar(),
          Container(
            color: Colors.white24,
            height: 8,
            margin: EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 30),
          ),
          Stack(
            children: [
              ScheduleWeek(),
              // Positioned(
              //     top: 55,
              //     left: 5,
              //     child: Text(
              //       "오전",
              //       style: TextStyle(color: Colors.white.withOpacity(0.6)),
              //     )),
              // Positioned(
              //     top: 80,
              //     left: 0,
              //     right: 0,
              //     child: Container(
              //       height: 1,
              //       color: Colors.white.withOpacity(0.2),
              //     )),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white54,
        child: Icon(Icons.add),
      ),
    );
  }
}
