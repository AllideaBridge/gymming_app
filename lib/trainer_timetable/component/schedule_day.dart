// import 'package:flutter/material.dart';
//
// import '../../user_timetable/component/schedule_list.dart';
//
// class ScheduleDay extends StatelessWidget {
//   final int month;
//   final int day;
//   final String dayOfWeek;
//
//   const ScheduleDay(
//       {Key? key,
//         required this.month,
//         required this.day,
//         required this.dayOfWeek})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var today = DateTime.now();
//     var isToday = false;
//     if (month == today.month && day == today.day) {
//       isToday = true;
//     }
//     return Container(
//       //color: isToday ? Colors.white24 : null,
//       decoration: isToday
//           ? BoxDecoration(
//           color: Colors.white24.withOpacity(0.1),
//           borderRadius: BorderRadius.only(
//               topRight: Radius.circular(30.0),
//               topLeft: Radius.circular(30.0)))
//           : null,
//       child: Column(
//         children: [
//           Container(
//             decoration: isToday
//                 ? BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.white12.withOpacity(0.1),
//                 border: Border.all(
//                     color: Colors.white,
//                     style: BorderStyle.solid,
//                     width: 1))
//                 : null,
//             width: 50,
//             height: 50,
//             // margin: EdgeInsets.only(bottom: 20),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   dayOfWeek,
//                   style: TextStyle(color: Colors.white, fontSize: 10),
//                 ),
//                 Text(
//                   "$month.$day",
//                   style: TextStyle(
//                       color: Colors.white, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               showModalBottomSheet(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return Container(
//                       height: 500,
//                       decoration: BoxDecoration(
//                           color: Color(0xff2d2d2d),
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(30),
//                             topRight: Radius.circular(30),
//                           )),
//                     );
//                   },
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(30),
//                         topRight: Radius.circular(30),
//                       )));
//             },
//             child: ScheduleDisplay(
//               time: DateTime.now(),
//               lesson: "PT",
//               isToday: isToday,
//               idx: 0,
//             ),
//           ),
//           ScheduleDisplay(
//             time: DateTime.now(),
//             lesson: "PT",
//             isToday: isToday,
//             idx: 1,
//           ),
//           ScheduleDisplay(
//             time: DateTime.now(),
//             lesson: "PT",
//             isToday: isToday,
//             idx: 1,
//           )
//         ],
//       ),
//     );
//   }
// }