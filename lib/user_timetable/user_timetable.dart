import 'package:flutter/material.dart';
import 'package:gymming_app/drawer/user_drawer.dart';
import 'package:gymming_app/explore/explore_main.dart';
import 'package:gymming_app/trainer_timetable/trainer_timetable.dart';
import 'package:gymming_app/user_timetable/component/calendar.dart';
import 'package:gymming_app/user_timetable/component/schedule_list.dart';

class UserTimeTable extends StatelessWidget {
  const UserTimeTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white),
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
      drawer: UserDrawer(),
      body: Column(
        children: [Calendar(), ScheduleList()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TrainerTimeTable()));
        },
        backgroundColor: Colors.white54,
        child: Icon(Icons.add),
      ),
    );
  }
}
