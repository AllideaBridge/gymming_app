import 'package:flutter/material.dart';
import 'package:gymming_app/explore/explore_screen.dart';
import 'package:gymming_app/user_timetable/component/calendar.dart';
import 'package:gymming_app/user_timetable/component/schedule_list.dart';

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
      drawer: const Drawer(),
      body: Column(
        children: [Calendar(), ScheduleDisplay()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white54,
        child: Icon(Icons.add),
      ),
    );
  }
}
