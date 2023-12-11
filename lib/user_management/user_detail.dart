import 'package:flutter/material.dart';
import 'package:gymming_app/common/constants.dart';
import 'package:gymming_app/user_timetable/component/calendar.dart';
import 'package:gymming_app/user_timetable/component/schedule_item.dart';

import '../user_timetable/model/schedule_info.dart';

class UserDetail extends StatelessWidget {
  // String from;

  UserDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('회원 관리'),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: 52.0, // 이미지의 너비
                      height: 52.0, // 이미지의 높이
                      decoration: BoxDecoration(
                        color: Colors.pink, // 초록색으로 채우기
                        shape: BoxShape.circle, // 동그란 모양으로 설정
                      )),
                  IconButton(
                    icon: Image.asset(
                      'assets/icon_nav_arrow_right.png',
                      height: 24,
                      width: 24,
                    ),
                    onPressed: () {
                      // 뒤로 가기 동작 또는 다른 작업을 수행
                      // Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Text('김운동',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white)),
              Text(
                '1998.06.16 | 남',
                style: TextStyle(color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        '3 / 10 진행 | 23.10.08 등록',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [],
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
              Calendar(),

            ],
          ),
        ),
      ),
    );
  }
}
