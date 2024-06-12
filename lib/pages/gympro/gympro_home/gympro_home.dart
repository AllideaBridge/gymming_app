import 'package:flutter/material.dart';
import 'package:gymming_app/pages/gympro/drawer/gympro_drawer.dart';
import 'package:gymming_app/pages/gympro/gympro_home/gympro_disable_time.dart';
import 'package:gymming_app/pages/gympro/gympro_home/lesson_data_source.dart';
import 'package:gymming_app/services/repositories/schedule_repository.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../common/colors.dart';
import '../../../services/models/lesson_list.dart';

class GymproHome extends StatefulWidget {
  const GymproHome({Key? key}) : super(key: key);

  //todo provider 에서 id 를 받아와야 함(혹은 로그인화면 이후)
  final int trainerId = 1;

  @override
  State<GymproHome> createState() => _GymproHomeState();
}

class _GymproHomeState extends State<GymproHome> {
  final scheduleRepository = ScheduleRepository(client: http.Client());
  Future<List<LessonList>> futureTrainerSchedules =
      Future<List<LessonList>>.value([]);

  @override
  void initState() {
    super.initState();
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      GymproDisableTime(trainerId: widget.trainerId)));
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
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            futureTrainerSchedules =
                scheduleRepository.getTrainerScheduleByWeek(dates[0]);
          });
        });
      },
    );
  }
}
