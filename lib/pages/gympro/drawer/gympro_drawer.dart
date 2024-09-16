import 'package:flutter/material.dart';
import 'package:gymming_app/pages/gymbie/gymbie_home/gymbie_home.dart';
import 'package:gymming_app/pages/gympro/gympro_member_connect/gympro_member_search.dart';
import 'package:gymming_app/pages/gympro/gympro_register.dart';

import '../../../common/colors.dart';
import '../../../components/layouts/tab_layout.dart';
import '../../../pages/gympro/gympro_member_mgmt/gympro_member_mgmt.dart';
import '../gympro_requests/gympro_finished_request_list.dart';
import '../gympro_requests/gympro_pending_request_list.dart';

class TrainerDrawer extends StatelessWidget {
  const TrainerDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 350,
      elevation: 0.0,
      backgroundColor: BACKGROUND_COLOR,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(20))),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: PRIMARY_COLOR,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text('트레이너',
                        style: TextStyle(
                            color: SECONDARY_COLOR,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          'GYMMING',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  // TODO trainerId 받아와서 넘기기
                                  builder: (context) => GymproRegister(
                                        type: 'edit',
                                        trainerId: 1,
                                      )),
                            );
                          },
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 18,
                            color: SECONDARY_COLOR,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    print('log out!');
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: BTN_COLOR,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: Text('로그아웃',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: SECONDARY_COLOR)),
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: BORDER_COLOR,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          SizedBox(
            height: 40,
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 1.5),
            title: Text(
              '새로운 회원 등록',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GymproMemberSearch()));
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 1.5),
            title: Text(
              '기존 회원 관리',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TabLayout(
                            title: "기존 회원 관리",
                            leftTabName: "현재 등록 회원",
                            rightTabName: "이전 등록 회원",
                            leftComponent: GymproMemberMgmt(isPresent: true),
                            rightComponent: GymproMemberMgmt(isPresent: false),
                          )));
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 1.5),
            title: Text(
              '요청 목록',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TabLayout(
                            title: "요청",
                            leftTabName: "응답 대기",
                            rightTabName: "완료",
                            leftComponent: GymproPendingRequestList(),
                            rightComponent: GymproFinishedRequestList(),
                          )));
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 1.5),
            title: Text(
              '회원 화면으로 이동',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onTap: () {
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => GymbieHome(),
                ),
                (route) =>
                    false, //if you want to disable back feature set to false
              );
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 1.5),
            title: Text(
              '트레이너 가입 하기',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onTap: () {
              Navigator.push<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => GymproRegister(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('드로어를 닫는다', style: TextStyle(color: Colors.white)),
            onTap: () {
              // 다른 작업
              Navigator.pop(context); // 드로어를 닫습니다.
            },
          ),
          // ... 다른 리스트 타일 항목들 ...
        ],
      ),
    );
  }
}
