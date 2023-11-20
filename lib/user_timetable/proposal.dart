import 'package:flutter/material.dart';
import 'package:gymming_app/user_timetable/user_timetable.dart';

class Proposal extends StatelessWidget {
  final String type;
  final DateTime originDay;
  final DateTime selectedDay;
  final String selectedTime;
  final String reason;

  const Proposal(
      {super.key,
      required this.type,
      required this.originDay,
      required this.selectedDay,
      required this.selectedTime,
      required this.reason});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '운동 일정 $type을(를)\n신청하셨습니다.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '일정 $type이(가) 확정된 것이 아니며, 트레이너 및\n지점 확인 후 승인 여부를 알려드리겠습니다.\n(최대 3시간 소요)',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 60),
              Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Icon(Icons.calendar_today,
                              color: Colors.white, size: 30.0),
                          Text("변경 전",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ))
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        '${originDay.month}월${originDay.day}일 ${originDay.hour}:00',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Icon(Icons.calendar_today,
                              color: Colors.white, size: 30.0),
                          Text("변경 후",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ))
                        ],
                      ),
                 
                      SizedBox(height: 20),
                      Text(
                        '${selectedDay.month}월${selectedDay.day}일 $selectedTime',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Icon(Icons.calendar_today,
                              color: Colors.white, size: 30.0),
                          Text("$type 사유",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ))
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        reason,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 40),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('변경 취소'),
                    style: ElevatedButton.styleFrom(primary: Colors.grey),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => UserTimeTable()),
                            (Route<dynamic> route) => false, // 모든 라우트를 제거하므로 false를 반환합니다.
                      );
                    },
                    child: Text('확인'),
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
