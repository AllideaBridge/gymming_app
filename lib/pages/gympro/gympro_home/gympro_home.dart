import 'package:flutter/material.dart';
import 'package:gymming_app/pages/gymbie/gymbie_home/gymbie_home.dart';
import 'package:gymming_app/pages/gympro/drawer/gympro_drawer.dart';
import 'package:gymming_app/pages/gympro/gympro_home/lesson_data_source.dart';
import 'package:gymming_app/services/repositories/lesson_repository.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../common/colors.dart';

class TrainerTimeTable extends StatefulWidget {
  const TrainerTimeTable({Key? key}) : super(key: key);

  @override
  State<TrainerTimeTable> createState() => _TrainerTimeTableState();
}

class _TrainerTimeTableState extends State<TrainerTimeTable> {
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
      drawer: TrainerDrawer(),
      body: Container(
        child: SfCalendar(
          view: CalendarView.week,
          dataSource: LessonDataSource(LessonRepository().getLessonList()),
          appointmentTextStyle: TextStyle(
            fontSize: 11,
            color: Colors.black,
          ),
          headerHeight: 0,
          timeSlotViewSettings: TimeSlotViewSettings(
            dayFormat: 'EEE',
            dateFormat: 'M.d',
            timeFormat: 'H',
            timeTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          cellBorderColor: BORDER_COLOR,
          viewHeaderStyle: ViewHeaderStyle(
            dayTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 10,
            ),
            dateTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
