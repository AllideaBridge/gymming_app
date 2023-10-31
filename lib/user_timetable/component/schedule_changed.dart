import 'package:flutter/material.dart';

import '../timetable.dart';

class ScheduleChanged extends StatelessWidget {
  const ScheduleChanged({super.key, required this.beforeTime, required this.afterTime});

  final DateTime beforeTime;
  final DateTime afterTime;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.signal_cellular_4_bar, color: Colors.white),
                SizedBox(width: 10),
                Icon(Icons.wifi, color: Colors.white),
                SizedBox(width: 10),
                Icon(Icons.battery_full, color: Colors.white),
              ],
            ),
          ),
          SizedBox(height: 100),
          Text(
            """운동 일정을\n변경 하였습니다.""",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
            ),
          ),
          Expanded(
            child: Center(
              child:Image.asset('assets/change_compeleted.png'), // 이미지의 경로를 입력해 주세요.
            ),
          ),
          ListTile(
            title: Text('변경 전', style: TextStyle(color: Colors.white)),
            trailing: Text('$beforeTime', style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            title: Text('변경 후', style: TextStyle(color: Colors.white)),
            trailing: Text('$afterTime', style: TextStyle(color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => TimeTable()),
                      (Route<dynamic> route) => false, // 모든 라우트를 제거하므로 false를 반환합니다.
                );
              },
              child: Text('확인'),
            ),
          ),
        ],
      ),
    );
  }
}
