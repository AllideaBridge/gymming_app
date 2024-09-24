import 'package:flutter/material.dart';
import 'package:gymming_app/pages/gymbie/gymbie_home/gymbie_home.dart';

import '../../common/colors.dart';
import '../../common/constants.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/buttons/secondary_button.dart';
import '../../services/repositories/change_ticket_repository.dart';
import '../../services/utils/date_util.dart';

class GymbieScheduleResolveTicket extends StatelessWidget {
  final String type;
  final DateTime originDay;
  final DateTime? selectedDay;
  final String? selectedTime;
  final String reason;
  final int changeTicketId;

  const GymbieScheduleResolveTicket(
      {super.key,
      required this.type,
      required this.originDay,
      this.selectedDay,
      this.selectedTime,
      required this.reason,
      required this.changeTicketId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(children: [
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '운동 일정 $type을(를)\n신청하셨습니다.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '일정 $type이(가) 확정된 것이 아니며, 트레이너 및\n지점 확인 후 승인 여부를 알려드리겠습니다.\n(최대 3시간 소요)',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 40),
                  buildTitleAndTime(type == CHANGE ? '변경 전' : '취소 일정',
                      originDay, '', SECONDARY_COLOR),
                  Visibility(
                    visible: type == CHANGE,
                    child: SizedBox(height: 40),
                  ),
                  selectedDay != null
                      ? buildTitleAndTime(
                          '변경 후', selectedDay, selectedTime, Colors.white)
                      : Container(),
                  SizedBox(height: 40),
                  buildTitleAndReason('$type 사유', reason),
                ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: SecondaryButton(
                  onPressed: () async {
                    await ChangeTicketRepository()
                        .deleteChangeTicket(changeTicketId);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => GymbieHome()),
                      (Route<dynamic> route) =>
                          false, // 모든 라우트를 제거하므로 false를 반환합니다.
                    );
                  },
                  title: type == CANCEL ? '취소 신청 철회' : '변경 취소',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                  child: PrimaryButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => GymbieHome()),
                    (Route<dynamic> route) =>
                        false, // 모든 라우트를 제거하므로 false를 반환합니다.
                  );
                },
                title: '확인',
              ))
            ],
          ),
        ]),
      ),
    ));
  }

  Widget buildTitleAndTime(
      String title, DateTime? time, String? hour, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/clock.png',
          width: 20,
          height: 20,
        ),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                  color: color,
                  fontSize: 18.0,
                )),
            SizedBox(height: 8),
            Text(
              hour!.isEmpty
                  ? DateUtil.getKoreanDayAndHour(time)
                  : DateUtil.getKoreanDayAndExactHour(time, hour),
              style: TextStyle(
                color: color,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildTitleAndReason(String title, String reason) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/talkBox.png',
          width: 20,
          height: 20,
        ),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                )),
            SizedBox(height: 8),
            Text(
              reason,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
