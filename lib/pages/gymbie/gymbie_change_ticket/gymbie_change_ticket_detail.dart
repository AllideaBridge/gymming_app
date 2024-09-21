import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gymming_app/services/repositories/change_ticket_repository.dart';
import 'package:http/http.dart' as http;

import '../../../common/colors.dart';
import '../../../common/constants.dart';
import '../../../components/buttons/primary_button.dart';
import '../../../components/buttons/secondary_button.dart';
import '../../../components/common_header.dart';
import '../../../components/icon_label.dart';
import '../../../services/models/change_ticket.dart';
import '../../../services/utils/date_util.dart';
import '../../../services/utils/toast_util.dart';

class GymbieChangeTicketDetail extends StatefulWidget {
  final ChangeTicket changeTicket;

  const GymbieChangeTicketDetail({super.key, required this.changeTicket});

  @override
  State<GymbieChangeTicketDetail> createState() =>
      _GymbieChangeTicketDetailState();
}

class _GymbieChangeTicketDetailState extends State<GymbieChangeTicketDetail> {
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  _showToast(msg) {
    fToast.showToast(
        child: ToastUtil.defaultToast(msg),
        toastDuration: Duration(seconds: 1),
        positionedToastBuilder: (context, child) {
          return Positioned(
            bottom: 176.0,
            left: 0,
            right: 0,
            child: child,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      CommonHeader(title: '요청 상세'),
      buildChangeTicketDetailTopSide(
          widget.changeTicket.trainerName!, widget.changeTicket.createdAt),
      Container(
        color: BACKGROUND_COLOR,
        height: 6,
      ),
      Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
          child: Column(children: [
            IconLabel(
                iconData: Icons.alarm,
                title: '변경 전',
                content:
                    DateUtil.getKoreanDayAndHour(widget.changeTicket.asIsDate),
                titleColor: SECONDARY_COLOR,
                contentColor: SECONDARY_COLOR),
            SizedBox(
              height: 40,
            ),
            IconLabel(
                iconData: Icons.alarm,
                title: '변경 후',
                content: widget.changeTicket.toBeDate != null
                    ? DateUtil.getKoreanDayAndHour(widget.changeTicket.toBeDate)
                    : '취소',
                titleColor: Colors.white,
                contentColor: Colors.white),
            SizedBox(
              height: 40,
            ),
            IconLabel(
                iconData: Icons.message_outlined,
                title: '변경 사유',
                content: widget.changeTicket.userMessage,
                titleColor: Colors.white,
                contentColor: Colors.white),
          ]),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: widget.changeTicket.changeTicketStatus ==
                ChangeTicketStatus.WAITING
            ? PrimaryButton(
                title: '요청 취소',
                onPressed: () async {
                  await ChangeTicketRepository(client: http.Client())
                      .deleteChangeTicket(widget.changeTicket.changeTicketId);
                  _showToast('취소되었습니다.');
                  Navigator.pop(context);
                })
            : SecondaryButton(
                title: '목록으로 이동',
                onPressed: () {
                  Navigator.pop(context);
                }),
      )
    ])));
  }

  buildChangeTicketDetailTopSide(String trainerName, DateTime createdAt) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 28),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Image.asset(
              //todo user 상세조회하여 가져오기
              'assets/images/user_example.png',
              fit: BoxFit.cover,
              width: 48.0,
              height: 48.0,
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    trainerName,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  SizedBox(width: 4.0),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: TERITARY_COLOR,
                    size: 16,
                  )
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                '${DateUtil.convertDateTimeWithDot(createdAt)} 요청',
                style: TextStyle(fontSize: 14, color: SECONDARY_COLOR),
              )
            ],
          )
        ],
      ),
    );
  }
}
