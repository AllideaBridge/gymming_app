import 'package:flutter/material.dart';
import 'package:gymming_app/common/constants.dart';

class RequestDetail extends StatelessWidget {
  String from;

  RequestDetail({super.key, required this.from});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('요청 상세'),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                          width: 32.0, // 이미지의 너비
                          height: 32.0, // 이미지의 높이
                          decoration: BoxDecoration(
                            color: Colors.green, // 초록색으로 채우기
                            shape: BoxShape.circle, // 동그란 모양으로 설정
                          )),
                      SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('김민희',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          Text(
                            '23. 10. 08. 16:07 요청',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      )
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // 응답 버튼 클릭 이벤트 처리
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.grey, // 버튼의 텍스트색
                    ),
                    child: Text('연락하기'),
                  ),
                ],
              ),
              Divider(
                thickness: 4,
                color: Colors.grey,
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if(from == COMPLETED_LIST)
                        Container(
                          color: Colors.green,
                          padding: EdgeInsets.all(8.0),
                          child: Text('승인'),
                        ),
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
                        // '${originDay.month}월${originDay.day}일 ${originDay.hour}:00',
                        '8월 6일 9:00',
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
                        // '${selectedDay.month}월${selectedDay.day}일 $selectedTime',
                        '8월 6일 9:00',
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
                          Text(
                              // "$type 사유",
                              '변경 사유',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ))
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        // reason,
                        '몸이 아픔',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              if (from == WAITING_LIST)
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // 응답 버튼 클릭 이벤트 처리
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.grey, // 버튼의 텍스트색
                      ),
                      child: Text('거절'),
                    ),
                    SizedBox(width: 12.0),
                    ElevatedButton(
                      onPressed: () {
                        // 확인 버튼 클릭 이벤트 처리
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green, // 버튼의 텍스트색
                      ),
                      child: Text('승인'),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
