import 'package:flutter/material.dart';
import 'package:gymming_app/pages/gympro/gympro_gymbie_add.dart';
import 'package:gymming_app/pages/gympro/gympro_gymbie_remove.dart';
import 'package:gymming_app/services/repositories/trainee_repository.dart';

import '../../../common/colors.dart';
import '../../../components/common_header.dart';
import '../../../services/models/trainee_detail.dart';
import '../../../services/models/trainer_user.dart';
import 'component/gympro_member_detail_calendar.dart';

class GymproMemberDetail extends StatelessWidget {
  final TrainerUser trainingUserDetail;

  //user detail 을 개별 API 통해서 가져오기 필요함..
  final TraineeDetail userDetail = TraineeRepository().getTraineeDetail();

  GymproMemberDetail({super.key, required this.trainingUserDetail});

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
                                  trainingUserDetail.userProfileImgUrl,
                                  fit: BoxFit.cover,
                                  width: 80.0,
                                  height: 80.0,
                                ),
                              ),
                              SizedBox(height: 16.0),
                              Text(
                                trainingUserDetail.userName,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    userDetail.birth,
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
                                    userDetail.gender,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: SECONDARY_COLOR,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                  trainingUserDetail
                                      .getTrainerUserListDetailText(true),
                                  style: TextStyle(
                                      fontSize: 16.0, color: SECONDARY_COLOR)),
                              Row(
                                children: [
                                  Text(
                                    userDetail.phoneNumber,
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
                                                traineeDetail: userDetail,
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
                                              name: userDetail.name)));
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
                          GymproMemberDetailCalendar(),
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
