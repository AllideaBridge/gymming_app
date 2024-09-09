import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gymming_app/components/buttons/primary_button.dart';
import 'package:gymming_app/components/buttons/secondary_button.dart';
import 'package:gymming_app/components/chips/grey_chip.dart';
import 'package:gymming_app/components/chips/primary_chip.dart';
import 'package:gymming_app/components/common_header.dart';
import 'package:gymming_app/components/icon_label.dart';
import 'package:gymming_app/pages/gympro/gympro_requests/gympro_pending_request_list.dart';
import 'package:gymming_app/services/models/change_ticket.dart';
import 'package:gymming_app/services/repositories/change_ticket_repository.dart';
import 'package:http/http.dart' as http;

import '../../../../common/colors.dart';
import '../../../../common/constants.dart';
import '../../../components/layouts/reason_content.dart';
import '../../../components/layouts/reason_layout.dart';
import '../../../services/utils/toast_util.dart';

class GymproRequestDetail extends StatefulWidget {
  final ChangeTicket changeTicket;

  GymproRequestDetail({super.key, required this.changeTicket});

  @override
  _GymproRequestDetailState createState() => _GymproRequestDetailState();
}

class _GymproRequestDetailState extends State<GymproRequestDetail> {
  late FToast fToast;
  late bool _isCompleted;
  late bool _isAccepted;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    // TODO status 상수화
    _isCompleted = widget.changeTicket.requestStatus != "WAITING";
    _isAccepted = widget.changeTicket.requestStatus == "APPROVED";
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
        child: Column(
          children: [
            CommonHeader(title: '요청 상세'),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image.asset(
                            widget.changeTicket.userProfileImage,
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
                                  widget.changeTicket.userName!,
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
                              '${widget.changeTicket.createdAt} 요청',
                              style: TextStyle(
                                  fontSize: 14, color: SECONDARY_COLOR),
                            )
                          ],
                        )
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {
                          // TODO: 클릭 시 연락 기능 추가
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: BTN_COLOR,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        child: Text(
                          '연락하기',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                )),
            Container(
              color: BACKGROUND_COLOR,
              height: 6,
            ),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 28, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _isCompleted
                            ? Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 28),
                                child: _isAccepted
                                    ? PrimaryChip(title: '승인')
                                    : GreyChip(title: '거절'))
                            : SizedBox.shrink(),
                        IconLabel(
                            iconData: Icons.alarm,
                            title: '변경 전',
                            content: widget.changeTicket.asIsDate.toString(),
                            titleColor: SECONDARY_COLOR,
                            contentColor: SECONDARY_COLOR),
                        SizedBox(
                          height: 40,
                        ),
                        IconLabel(
                            iconData: Icons.alarm,
                            title: '변경 후',
                            content: widget.changeTicket.toBeDate.toString(),
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
                      ],
                    ))),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: SizedBox(
                    height: 56,
                    child: Row(
                      children: _isCompleted
                          ? [
                              SecondaryButton(
                                  title: '목록으로 이동',
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                GymproPendingRequestList()));
                                  })
                            ]
                          : [
                              SecondaryButton(
                                  title: '거절',
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Reason(
                                                  reasonContent: ReasonContent(
                                                      REJECT_TITLE,
                                                      REJECT_SUBTITLE,
                                                      REJECT_REASONS),
                                                  requestId: widget
                                                      .changeTicket.requestId,
                                                  type: REJECT,
                                                )));
                                  }),
                              SizedBox(width: 12),
                              PrimaryButton(
                                title: '승인',
                                onPressed: () {
                                  sendApproveChangeTicket();
                                  _showToast('승인 되었습니다.');
                                  setState(() {
                                    _isCompleted = true;
                                    _isAccepted = true;
                                  });
                                },
                              )
                            ],
                    )))
          ],
        ),
      ),
    );
  }

  void sendApproveChangeTicket() async {
    final body = {
      'change_from': 'TRAINER',
      'status': 'APPROVED',
      'start_time': widget.changeTicket.toBeDate,
    };
    await ChangeTicketRepository(client: http.Client())
        .modifyChangeTicket(widget.changeTicket.requestId, body);
  }
}
