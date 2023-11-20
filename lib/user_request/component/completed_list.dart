import 'package:flutter/material.dart';
import 'package:gymming_app/common/constants.dart';

import '../request_detail.dart';

class CompletedList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 20, // 임시 데이터의 수

      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => RequestDetail(from: COMPLETED_LIST,)));
          },
          child: Card(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [
                          Container(
                              width: 32.0, // 이미지의 너비
                              height: 32.0, // 이미지의 높이
                              decoration: BoxDecoration(
                                color: Colors.purple, // 초록색으로 채우기
                                shape: BoxShape.circle, // 동그란 모양으로 설정
                              )),
                          SizedBox(width: 8,),
                          Text('김민희',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ],
                      ),
                      Text(
                        '23. 10. 08. 16:07 요청',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  // 아이템 사이의 구분선을 추가할 수도 있습니다.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Column(
                          children: [
                            Text(
                              '8월 6일 목 09:00 기존',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              '8월 7일 금 20:00 변경',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          index%2 == 0? ElevatedButton(
                            onPressed: () {
                              // 응답 버튼 클릭 이벤트 처리
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.grey, // 버튼의 텍스트색
                            ),
                            child: Text('거절'),
                          )
                          :
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
                  // 더 많은 위젯 추가 가능...
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
