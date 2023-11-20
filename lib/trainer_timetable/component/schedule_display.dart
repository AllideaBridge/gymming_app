// import 'package:flutter/material.dart';
// import 'package:gymming_app/state/state_date_time.dart';
// import 'package:gymming_app/user_timetable/component/schedule_view.dart';
// import 'package:provider/provider.dart';
//
// import '../model/schedule_info.dart';
//
// class ScheduleDisplay extends StatelessWidget {
//   const ScheduleDisplay({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     List<ScheduleInfo> schedules = List.generate(
//         3,
//             (index) => ScheduleInfo(
//             DateTime.now(), DateTime.now(), "PT", "김헬스", "GYMMING", "방이동"));
//
//     return Container(
//       margin: EdgeInsets.only(top: 20),
//       color: Colors.grey,
//       child: Column(
//         children: [
//           Container(
//             child: Column(
//               children: [
//                 Text("오늘은"),
//                 Text(
//                     "${Provider.of<StateDateTime>(context).selectedDateTime.month}월 ${Provider.of<StateDateTime>(context).selectedDateTime.day}일")
//               ],
//             ),
//           ),
//           for (var i = 0; i < schedules.length; i++)
//             GestureDetector(
//               onTap: () {
//                 showModalBottomSheet(
//                     context: context,
//                     shape: RoundedRectangleBorder(
//                         borderRadius:
//                         BorderRadius.vertical(top: Radius.circular(25.0))),
//                     builder: (BuildContext context) {
//                       return Container(
//                         decoration: BoxDecoration(
//                             color: Color(0xff2d2d2d),
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(25),
//                               topRight: Radius.circular(25),
//                             )),
//                         child: Column(
//                           children: [
//                             Row(
//                               children: [
//                                 OutlinedButton(
//                                     onPressed: null,
//                                     child: Text(
//                                       "취소하기",
//                                       style: TextStyle(color: Colors.white),
//                                     )),
//                                 OutlinedButton(
//                                     onPressed: null,
//                                     child: Text(
//                                       "변경하기",
//                                       style: TextStyle(color: Colors.white),
//                                     ))
//                               ],
//                             )
//                           ],
//                         ),
//                       );
//                     });
//               },
//               child: ScheduleView(scheduleInfo: schedules[i]),
//             ),
//         ],
//       ),
//     );
//   }
// }