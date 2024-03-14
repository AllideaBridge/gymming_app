import 'package:flutter/material.dart';
import 'package:gymming_app/common/colors.dart';
import 'package:gymming_app/models/trainee_detail.dart';
import 'package:gymming_app/trainee_registration/trainee_delete.dart';
import 'package:gymming_app/trainee_registration/trainee_input.dart';

import '../common/component/common_header.dart';
import '../repositories/trainee_repository.dart';
import 'component/calendar_trainee_detail.dart';

class UserDetail extends StatelessWidget {
  final TraineeDetail traineeDetail = TraineeRepository().getTraineeDetail();

  UserDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Column(
          children: [
            CommonHeader(title: '기존 회원 관리'),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 28.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(80.0),
                                child: Image.asset(
                                  traineeDetail.profileImg,
                                  fit: BoxFit.cover,
                                  width: 80.0,
                                  height: 80.0,
                                ),
                              ),
                              SizedBox(height: 16.0),
                              Text(
                                traineeDetail.name,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    traineeDetail.birth,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: SECONDARY_COLOR,
                                    ),
                                  ),
                                  Container(
                                    width: 2,
                                    height: 16,
                                    color: BORDER_COLOR,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                  ),
                                  Text(
                                    traineeDetail.gender,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: SECONDARY_COLOR,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    traineeDetail.weekDay,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: SECONDARY_COLOR,
                                    ),
                                  ),
                                  Container(
                                    width: 2,
                                    height: 16,
                                    color: BORDER_COLOR,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                  ),
                                  Text(
                                    '${traineeDetail.usedDay}/${traineeDetail.totalDay} 진행',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: SECONDARY_COLOR,
                                    ),
                                  ),
                                  Container(
                                    width: 2,
                                    height: 16,
                                    color: BORDER_COLOR,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                  ),
                                  Text(
                                    '${traineeDetail.registeredDay} 등록',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: SECONDARY_COLOR,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    traineeDetail.phoneNumber,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: SECONDARY_COLOR,
                                    ),
                                  ),
                                  SizedBox(width: 12.0),
                                  ElevatedButton(
                                    onPressed: () {
                                      // TODO: 연락하기 클릭 이벤트
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        minimumSize: Size(0, 25),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        foregroundColor: Colors.white,
                                        backgroundColor: BTN_COLOR,
                                        textStyle: TextStyle(
                                          fontSize: 14,
                                        )),
                                    child: Text('연락하기'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          PopupMenuButton(
                            icon: Icon(Icons.more_vert,
                                color: Colors.white, size: 20),
                            color: BACKGROUND_COLOR,
                            itemBuilder: (BuildContext context) => [
                              PopupMenuItem(
                                padding: EdgeInsets.fromLTRB(16, 0, 50, 0),
                                child: Text(
                                  '내용 편집',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TraineeInput(
                                                isRegister: false,
                                                traineeDetail: traineeDetail,
                                              )));
                                },
                              ),
                              PopupMenuItem(
                                padding: EdgeInsets.fromLTRB(16, 0, 50, 0),
                                child: Text(
                                  '삭제',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TraineeDelete(
                                              name: traineeDetail.name)));
                                },
                              ),
                            ],
                            offset: Offset(-5, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              side: BorderSide(color: TERITARY_COLOR),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 12,
                      height: 12,
                      color: BACKGROUND_COLOR,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 28.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '수업 진행 이력',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: SECONDARY_COLOR,
                            ),
                          ),
                          SizedBox(height: 20),
                          CalendarTraineeDetail(
                              lessonDay: traineeDetail.lessonDay),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
