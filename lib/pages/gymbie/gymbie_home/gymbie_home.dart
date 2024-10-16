import 'package:flutter/material.dart';
import 'package:gymming_app/pages/gymbie/drawer/gymbie_drawer.dart';
import 'package:gymming_app/pages/gymbie/gymbie_home/component/gymbie_home_calendar.dart';
import 'package:gymming_app/pages/gymbie/gymbie_schedule_trainer_list.dart';
import 'package:provider/provider.dart';

import '../../../state/info_state.dart';
import 'component/gymbie_schedule_list.dart';

class GymbieHome extends StatelessWidget {
  const GymbieHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white),
        title: const Text("Timetable"),
        backgroundColor: Colors.black,
      ),
      drawer: GymbieDrawer(),
      body: Column(
        children: [GymbieHomeCalendar(), GymbieScheduleList()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GymbieScheduleTrainerList(
                      userId: Provider.of<InfoState>(context).userId!)));
        },
        backgroundColor: Colors.white54,
        child: Icon(Icons.add),
      ),
    );
  }
}
