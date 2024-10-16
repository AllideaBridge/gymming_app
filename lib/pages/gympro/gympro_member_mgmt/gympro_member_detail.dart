import 'package:flutter/material.dart';
import 'package:gymming_app/pages/gympro/gympro_gymbie_remove.dart';
import 'package:gymming_app/pages/gympro/gympro_member_connect/gympro_member_connect.dart';
import 'package:gymming_app/pages/gympro/gympro_member_mgmt/gympro_member_extend.dart';
import 'package:gymming_app/services/repositories/trainer_user_repository.dart';
import 'package:gymming_app/services/utils/date_util.dart';

import '../../../common/colors.dart';
import '../../../components/common_header.dart';
import '../../../services/models/trainer_user_detail.dart';
import 'component/gympro_member_detail_calendar.dart';

class GymproMemberDetail extends StatefulWidget {
  final int trainerId;
  final int userId;
  final bool isPresent;

  const GymproMemberDetail(
      {super.key,
      required this.trainerId,
      required this.userId,
      required this.isPresent});

  @override
  State<StatefulWidget> createState() => _GymproMemberDetailState();
}

class _GymproMemberDetailState extends State<GymproMemberDetail> {
  late Future<TrainerUserDetail> trainerUserDetail;

  @override
  void initState() {
    super.initState();
    refreshTrainerUserDetail();
  }

  void refreshTrainerUserDetail() {
    trainerUserDetail = TrainerUserRepository()
        .getTrainerUserDetail(widget.trainerId, widget.userId);
  }

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
                    FutureBuilder(
                      future: trainerUserDetail,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final detail = snapshot.data!;
                          return buildTrainerUserDetail(context, detail);
                        } else if (snapshot.hasError) {
                          return Text(
                            "${snapshot.error}",
                            style: TextStyle(color: Colors.white),
                          );
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                    Divider(
                      thickness: 12,
                      height: 12,
                      color: BACKGROUND_COLOR,
                    ),
                    GymproMemberDetailCalendar(userId: widget.userId),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTrainerUserDetail(
      BuildContext context, TrainerUserDetail trainerUserDetail) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 28.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(80.0),
                child: trainerUserDetail.profileImgUrl != null
                    ? Image.network(
                        trainerUserDetail.profileImgUrl!,
                        fit: BoxFit.cover,
                        width: 80.0,
                        height: 80.0,
                      )
                    : Image.asset(
                        'assets/images/user_example.png',
                        fit: BoxFit.cover,
                        width: 80.0,
                        height: 80.0,
                      ),
              ),
              SizedBox(height: 16.0),
              Text(
                trainerUserDetail.name,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  Text(
                    DateUtil.convertDateTimeWithDot(trainerUserDetail.birthday),
                    style: TextStyle(
                      fontSize: 20,
                      color: SECONDARY_COLOR,
                    ),
                  ),
                  Container(
                    width: 2,
                    height: 16,
                    color: BORDER_COLOR,
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                  Text(
                    trainerUserDetail.gender,
                    style: TextStyle(
                      fontSize: 20,
                      color: SECONDARY_COLOR,
                    ),
                  ),
                ],
              ),
              Text(
                  trainerUserDetail
                      .getTrainerUserListDetailText(widget.isPresent),
                  style: TextStyle(fontSize: 16.0, color: SECONDARY_COLOR)),
              Row(
                children: [
                  Text(
                    trainerUserDetail.phoneNumber,
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
                          borderRadius: BorderRadius.circular(4),
                        ),
                        minimumSize: Size(0, 25),
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
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
            icon: Icon(Icons.more_vert, color: Colors.white, size: 20),
            color: BACKGROUND_COLOR,
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                padding: EdgeInsets.fromLTRB(16, 0, 50, 0),
                child: Text(
                  '연장 등록',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                onTap: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GymproMemberExtend(
                                userId: widget.userId,
                                trainerUserDetail: trainerUserDetail,
                              )));
                  setState(() {
                    refreshTrainerUserDetail();
                  });
                },
              ),
              PopupMenuItem(
                padding: EdgeInsets.fromLTRB(16, 0, 50, 0),
                child: Text(
                  '내용 편집',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                onTap: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GymproMemberConnect(
                                userId: widget.userId,
                                trainerUserDetail: trainerUserDetail,
                                isEdit: true,
                              )));
                  setState(() {
                    refreshTrainerUserDetail();
                  });
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
                          builder: (context) =>
                              TraineeDelete(name: trainerUserDetail.name)));
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
    );
  }
}
