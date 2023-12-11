import 'package:flutter/material.dart';
import 'package:gymming_app/common/constants.dart';
import 'package:gymming_app/user_management/user_detail.dart';

import '../user_request/request_detail.dart';

class UserManagementList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 20, // 임시 데이터의 수

      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserDetail()));
          },
          child: Card(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: Row(
                children: <Widget>[
                  Container(
                      width: 32.0, // 이미지의 너비
                      height: 32.0, // 이미지의 높이
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Colors.purple, // 초록색으로 채우기
                        shape: BoxShape.circle, // 동그란 모양으로 설정
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('김민희',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '3 / 10 진행 | 23.10.08. 등록',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Colors.grey,
          thickness: 1,
        );
      },
    );
  }
}
