import 'package:flutter/material.dart';
import 'package:gymming_app/pages/gymbie/gymbie_home/gymbie_home.dart';
import 'package:gymming_app/pages/gympro/drawer/gympro_drawer.dart';
import 'package:gymming_app/pages/gympro/gympro_home/lesson_data_source.dart';
import 'package:gymming_app/services/repositories/schedule_repository.dart';
import 'package:gymming_app/services/utils/date_util.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../common/colors.dart';
import '../../../services/models/lesson_list.dart';

class TrainerTimeTable extends StatefulWidget {
  const TrainerTimeTable({Key? key}) : super(key: key);

  @override
  State<TrainerTimeTable> createState() => _TrainerTimeTableState();
}

class _TrainerTimeTableState extends State<TrainerTimeTable> {
  final scheduleRepository = ScheduleRepository(client: http.Client());
  late Future<List<LessonList>> futureTrainerSchedules;

  @override
  void initState() {
    super.initState();
    futureTrainerSchedules =
        scheduleRepository.getTrainerScheduleByWeek(DateTime.now());
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
            icon: Image.asset('assets/images/alarm.png'),
          )
        ],
        backgroundColor: Colors.black,
      ),
      drawer: TrainerDrawer(),
      body: FutureBuilder(
        future: futureTrainerSchedules,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final schedules = snapshot.data!;
            return buildCalendar(schedules);
          } else if (snapshot.hasError) {
            return Text(
              "${snapshot.error}",
              style: TextStyle(color: Colors.white),
            );
          }
          return const CircularProgressIndicator();
        },
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

  Widget buildCalendar(List<LessonList> trainerSchedules) {
    return SfCalendar(
      view: CalendarView.week,
      dataSource: LessonDataSource(trainerSchedules),
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
      onViewChanged: (ViewChangedDetails details) {
        List<DateTime> dates = details.visibleDates;
        if (!DateUtil.isTodayInDateList(dates)) {
          setState(() {
            futureTrainerSchedules =
                scheduleRepository.getTrainerScheduleByWeek(dates[0]);
          });
        }
      },
    );
  }
}
