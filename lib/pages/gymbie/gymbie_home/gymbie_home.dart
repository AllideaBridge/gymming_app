import 'package:flutter/material.dart';
import 'package:gymming_app/pages/gymbie/drawer/gymbie_drawer.dart';
import 'package:gymming_app/pages/gymbie/explore/explore_main.dart';
import 'package:gymming_app/pages/gymbie/gymbie_home/component/gymbie_home_calendar.dart';
import 'package:gymming_app/pages/gymbie/gymbie_home/component/gymbie_schedule_list.dart';
import 'package:gymming_app/pages/gympro/gympro_home/gympro_home.dart';

class GymbieHome extends StatelessWidget {
  const GymbieHome({Key? key}) : super(key: key);

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
          Image.asset('assets/images/arrow.png')
        ],
        backgroundColor: Colors.black,
      ),
      drawer: UserDrawer(),
      body: Column(
        children: [GymbieHomeCalendar(), GymbieScheduleList()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => GymproHome()));
        },
        backgroundColor: Colors.white54,
        child: Icon(Icons.add),
      ),
    );
  }
}
