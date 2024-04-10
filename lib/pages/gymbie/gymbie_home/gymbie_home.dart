import 'package:flutter/material.dart';
import 'package:gymming_app/common/colors.dart';
import 'package:gymming_app/pages/gymbie/drawer/gymbie_drawer.dart';
import 'package:gymming_app/pages/gymbie/explore/explore_main.dart';
import 'package:gymming_app/pages/gymbie/gymbie_home/component/gymbie_home_calendar.dart';
import 'package:gymming_app/pages/gymbie/gymbie_home/component/gymbie_schedule_list.dart';
import 'package:gymming_app/pages/gympro/gympro_home/gympro_home.dart';

class UserTimeTable extends StatelessWidget {
  const UserTimeTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        titleSpacing: 0,
        titleTextStyle: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white),
        title: const Text("Timetable"),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ExploreScreen()));
            },
            child: Row(
              children: [
                Text(
                  '둘러보기',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 12,
                ),
                SizedBox(width: 20)
              ],
            ),
          )
        ],
        backgroundColor: Colors.black,
      ),
      drawer: UserDrawer(),
      body: Column(
        children: [
          advertisementContainer(),
          GymbieHomeCalendar(),
          GymbieScheduleList()
        ],
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

  //타임테이블, 둘러보기 시 사용할 화면
  Widget advertisementContainer() {
    return Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          color: BORDER_COLOR,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.close,
                color: Colors.white,
                size: 20,
              )
            ],
          ),
        ));
  }
}
