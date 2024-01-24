import 'package:flutter/material.dart';
import 'package:gymming_app/common/colors.dart';
import 'package:gymming_app/common/constants.dart';
import 'package:gymming_app/repositories/request_repository.dart';
import 'package:gymming_app/user_request/request_detail.dart';

import '../../models/request_list.dart';

class ResponseWaitingList extends StatelessWidget {
  final List<RequestList> requestList = RequestRepository().getRequestList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: ListView.separated(
        itemCount: requestList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RequestDetail(
                            from: WAITING_LIST,
                          )));
            },
            child: Card(
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.asset(
                      requestList[index].profileImg,
                      fit: BoxFit.cover,
                      width: 32.0,
                      height: 32.0,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              requestList[index].name,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              '${requestList[index].requestDay} 요청',
                              style: TextStyle(
                                  fontSize: 14, color: SECONDARY_COLOR),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: requestList[index].type == CHANGE
                                  ? [
                                      Text(
                                        '${requestList[index].originDay} 기존',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: SECONDARY_COLOR),
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        '${requestList[index].changeDay} 변경',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ]
                                  : [
                                      Text(
                                        '${requestList[index].originDay} 취소',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: SECONDARY_COLOR),
                                      ),
                                    ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 58.0,
                                  height: 32.0,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // 거절 버튼 클릭 이벤트 처리
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: BTN_COLOR,
                                    ),
                                    child: Text(
                                      '거절',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                SizedBox(
                                  width: 58.0,
                                  height: 32.0,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // 승인 버튼 클릭 이벤트 처리
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: PRIMARY_COLOR,
                                    ),
                                    child: Text(
                                      '승인',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: BORDER_COLOR,
            thickness: 1,
            height: 32.0,
          );
        },
      ),
    );
  }
}
