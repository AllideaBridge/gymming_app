import 'package:flutter/material.dart';
import 'package:gymming_app/components/icon_label.dart';
import 'package:gymming_app/pages/gympro/drawer/gympro_drawer.dart';
import 'package:gymming_app/pages/gympro/gympro_home/gympro_disable_time.dart';
import 'package:gymming_app/pages/gympro/gympro_home/lesson_data_source.dart';
import 'package:gymming_app/services/repositories/schedule_repository.dart';
import 'package:gymming_app/services/utils/date_util.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../common/colors.dart';
import '../../../services/models/lesson_list.dart';
import '../../../state/info_state.dart';

class GymproHome extends StatefulWidget {
  const GymproHome({Key? key}) : super(key: key);

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GymproDisableTime(
                      trainerId: Provider.of<InfoState>(context).trainerId!)));
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
      onTap: (CalendarTapDetails details) {
        showScheduleBottomSheet(context, details);
      },
      onViewChanged: (ViewChangedDetails details) {
        List<DateTime> dates = details.visibleDates;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            futureTrainerSchedules =
                scheduleRepository.getTrainerScheduleByWeek(dates[0],
                    Provider.of<InfoState>(context, listen: false).trainerId!);
          });
        });
      },
    );
  }

  void showScheduleBottomSheet(
      BuildContext context, CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment) {
      final Appointment appointmentDetails = details.appointments![0];
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Wrap(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  child: Container(
                    color: BORDER_COLOR,
                    padding: EdgeInsets.fromLTRB(20, 32, 20, 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconLabel(
                          iconData: Icons.alarm,
                          title: "일시",
                          content: DateUtil.getKoreanDayAndHour(
                              appointmentDetails.startTime),
                          titleColor: SECONDARY_COLOR,
                          contentColor: Colors.white,
                        ),
                        SizedBox(height: 40.0),
                        IconLabel(
                          iconData: Icons.person,
                          title: "회원",
                          content: appointmentDetails.subject,
                          titleColor: SECONDARY_COLOR,
                          contentColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          });
    }
  }
}
