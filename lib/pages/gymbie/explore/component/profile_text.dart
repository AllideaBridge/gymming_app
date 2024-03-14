import 'package:flutter/material.dart';
import 'package:gymming_app/services/models/trainer_detail.dart';

import '../../../../common/colors.dart';

Widget ProfileText(TrainerDetail trainerDetail) {
  return Container(
      margin: EdgeInsets.fromLTRB(20, 24, 20, 40),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Text(trainerDetail.name,
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            SizedBox(width: 8),
            Text(trainerDetail.position,
                style: TextStyle(fontSize: 16, color: SECONDARY_COLOR))
          ],
        ),
        SizedBox(height: 24),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            color: BTN_COLOR, // 배경색
          ),
          padding: EdgeInsets.all(16),
          child: Center(
            child: Text(trainerDetail.profileMsg,
                style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ),
        SizedBox(height: 24),
        Text('소속', style: TextStyle(fontSize: 14, color: SECONDARY_COLOR)),
        SizedBox(height: 8),
        Text('${trainerDetail.location} | ${trainerDetail.centerName}',
            style: TextStyle(fontSize: 16, color: Colors.white)),
        SizedBox(height: 24),
        Text('수업 가능 시간',
            style: TextStyle(fontSize: 14, color: SECONDARY_COLOR)),
        SizedBox(height: 8),
        Text(
            '평일 ${trainerDetail.weekdayTime} | 주말 ${trainerDetail.weekendTime}',
            style: TextStyle(fontSize: 16, color: Colors.white)),
        SizedBox(height: 24),
        Text('회원 수', style: TextStyle(fontSize: 14, color: SECONDARY_COLOR)),
        SizedBox(height: 8),
        Text(
            '현 ${trainerDetail.currentMemberCount}명 | 누적 ${trainerDetail.totalMemberCount}명',
            style: TextStyle(fontSize: 16, color: Colors.white)),
        SizedBox(height: 24),
        Text('이력', style: TextStyle(fontSize: 14, color: SECONDARY_COLOR)),
        SizedBox(height: 8),
        Text(trainerDetail.history,
            style: TextStyle(fontSize: 16, color: Colors.white, height: 1.6)),
        SizedBox(height: 24),
        Text('교육사항', style: TextStyle(fontSize: 14, color: SECONDARY_COLOR)),
        SizedBox(height: 8),
        Text(trainerDetail.education,
            style: TextStyle(fontSize: 16, color: Colors.white, height: 1.6)),
        SizedBox(height: 24),
        Text('가격', style: TextStyle(fontSize: 14, color: SECONDARY_COLOR)),
        SizedBox(height: 8),
        Text(
            '${trainerDetail.priceOf30}원 | 30회 기준\n${trainerDetail.priceOf20}원 | 20회 기준\n${trainerDetail.priceOf10}원 | 10회 기준',
            style: TextStyle(fontSize: 16, color: Colors.white, height: 1.6)),
        SizedBox(height: 24),
        ElevatedButton(
          // TODO: 클릭시 이벤트 추가
          onPressed: null,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(PRIMARY_COLOR),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              minimumSize:
                  MaterialStateProperty.all(Size(double.infinity, 56))),
          child: const Text(
            '상담 메시지 남기기',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ]));
}
