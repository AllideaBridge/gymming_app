import 'package:flutter/material.dart';
import 'package:gymming_app/pages/gymbie/gymbie_register.dart';
import 'package:gymming_app/pages/gympro/gympro_home/gympro_home.dart';
import 'package:gymming_app/pages/sample/sample_page.dart';

import '../../../common/colors.dart';
import '../../../components/layouts/tab_layout.dart';
import '../../../pages/gympro/gympro_requests/gympro_finished_request_list.dart';
import '../../../pages/gympro/gympro_requests/gympro_pending_request_list.dart';

class GymbieDrawer extends StatelessWidget {
  const GymbieDrawer({super.key});

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
                    Text('회원',
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
                                  builder: (context) =>
                                      // TODO userId 받아와서 넘기기
                                      GymbieRegister(
                                        type: 'edit',
                                        userId: 1,
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
              '내가 보낸 요청',
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
              '알림 수신 관리',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 1.5),
            title: Text(
              '광고 미노출 환경 구매',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 1.5),
            title: Text(
              '앱 공지사항',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          // TODO 아래 두 메뉴 제거
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 1.5),
            title: Text(
              '트레이너 페이지로 이동',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GymproHome()));
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 1.5),
            title: Text(
              '샘플 페이지로 이동',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SamplePage()));
            },
          ),
        ],
      ),
    );
  }
}
