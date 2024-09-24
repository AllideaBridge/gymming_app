import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gymming_app/components/buttons/primary_button.dart';
import 'package:gymming_app/components/common_header.dart';
import 'package:gymming_app/pages/gymbie/gymbie_schedule_resolve_ticket.dart';
import 'package:gymming_app/services/repositories/change_ticket_repository.dart';
import 'package:gymming_app/services/utils/date_util.dart';

import '../../common/colors.dart';
import '../../common/constants.dart';
import '../../services/models/schedule_user.dart';
import '../../services/utils/toast_util.dart';
import 'reason_content.dart';

class Reason extends StatefulWidget {
  //변경,취소 관련 문자열 및 사유
  final ReasonContent reasonContent;

  //변경될 스케쥴 객체
  final ScheduleUser? scheduleDetail;

  //기존에 선택한 시간
  final DateTime originalDay;

  //새롭게 선택한 시간(오직 변경인 경우에만 해당함)
  final DateTime? selectedDay;
  final String? selectedTime;

  //changeTicketId
  final int? changeTicketId;

  //changeTicket의 change_type (CANCEL,MODIFY)
  final String type;

  //reason 을 작성하는 주체 ('USER', 'TRAINER')
  final String requesterType;

  const Reason(
      {super.key,
      required this.reasonContent,
      this.scheduleDetail,
      this.selectedDay,
      this.selectedTime,
      this.changeTicketId,
      required this.type,
      required this.originalDay,
      required this.requesterType});

  @override
  ReasonState createState() => ReasonState();
}

class ReasonState extends State<Reason> {
  final textController = TextEditingController();
  late FToast fToast;

  bool isOpen = false;
  int clicked = 0;
  int textLength = 0;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);

    textController.addListener(() {
      setState(() {
        textLength = textController.text.length;
      });
    });
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
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CommonHeader(title: getReasonHeaderTitle()),
              buildReasonHeader(),
              buildReasonTextfield(),
              PrimaryButton(
                  title: '확인',
                  onPressed: () async {
                    if (widget.requesterType == 'TRAINER') {
                      //trainer 의 change ticket 거절 api
                      if (widget.type == ChangeTicketType.MODIFY) {
                        rejectModifyTypeChangeTicket();
                      } else {
                        rejectCancelTypeChangeTicket();
                      }
                      _showToast('운동 일정 변경을 거절하셨습니다.');
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else {
                      //user 의 change ticket 생성 api
                      int changeTicketId;
                      if (widget.type == ChangeTicketType.MODIFY) {
                        changeTicketId = await createModifyTypeChangeTicket();
                      } else {
                        changeTicketId = await createCancelTypeChangeTicket();
                      }
                      moveToCompletePage(context, changeTicketId);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  String getReasonHeaderTitle() {
    if (widget.requesterType == 'TRAINER') {
      return '일정 변경 거절';
    }

    if (widget.type == ChangeTicketType.MODIFY) {
      return '일정 변경';
    } else {
      return '일정 취소';
    }
  }

  Container buildReasonHeader() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 40, horizontal: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.reasonContent.title,
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Text(widget.reasonContent.subtitle,
              style: TextStyle(fontSize: 16, color: Colors.white)),
        ],
      ),
    );
  }

  Expanded buildReasonTextfield() {
    return Expanded(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isOpen = !isOpen;
              });
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: isOpen ? PRIMARY_COLOR : SECONDARY_COLOR,
                        width: 2)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.reasonContent.reasons[clicked],
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  isOpen
                      ? Image.asset('assets/images/icon_nav_arrow_up.png',
                          width: 20, height: 20)
                      : Image.asset('assets/images/icon_nav_arrow_down.png',
                          width: 20, height: 20),
                ],
              ),
            ),
          ),
          if (isOpen)
            Container(
              height: 248,
              margin: EdgeInsets.fromLTRB(0, 11, 0, 0),
              padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
              decoration: BoxDecoration(
                  border: Border.all(color: PRIMARY_COLOR),
                  borderRadius: BorderRadius.circular(4),
                  color: BACKGROUND_COLOR),
              child: Scrollbar(
                thumbVisibility: true,
                thickness: 4.0,
                radius: Radius.circular(10.0),
                child: ListView.builder(
                    itemCount: widget.reasonContent.reasons.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            clicked = index;
                            isOpen = !isOpen;
                          });
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 0),
                            child: Text(widget.reasonContent.reasons[index],
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white))),
                      );
                    }),
              ),
            ),
          if (widget.reasonContent.reasons[clicked] == '직접 입력' && !isOpen)
            Container(
              margin: EdgeInsets.only(top: 12),
              height: 180,
              child: Stack(
                children: [
                  TextField(
                    controller: textController,
                    maxLines: 50,
                    decoration: InputDecoration(
                      hintText: '${widget.type}하시려는 사유를 입력해주세요.',
                      hintStyle: TextStyle(fontSize: 18, color: TERITARY_COLOR),
                      filled: true,
                      fillColor: BACKGROUND_COLOR,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Positioned(
                    right: 16,
                    bottom: 12,
                    child: Text(
                      '$textLength / 100',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  //회원이 날리는 변경 타입 change ticket 생성 메소드
  Future<int> createModifyTypeChangeTicket() async {
    final body = {
      'schedule_id': widget.scheduleDetail?.scheduleId,
      'change_from': widget.requesterType,
      'change_type': widget.type,
      'change_reason': clicked == 0
          ? textController.text
          : widget.reasonContent.reasons[clicked],
      'start_time': DateUtil.convertDatabaseFormatFromDayAndTime(
          widget.selectedDay!, widget.selectedTime!),
      'as_is_date': DateUtil.convertDatabaseFormatDateTime(widget.originalDay)
    };
    int response = await ChangeTicketRepository().createChangeTicket(body);
    return response;
  }

  //회원이 날리는 취소 타입 change ticket 생성 메소드
  Future<int> createCancelTypeChangeTicket() async {
    final body = {
      'schedule_id': widget.scheduleDetail?.scheduleId,
      'change_from': widget.requesterType,
      'change_type': widget.type,
      'change_reason': clicked == 0
          ? textController.text
          : widget.reasonContent.reasons[clicked],
      'as_is_date': DateUtil.convertDatabaseFormatDateTime(widget.originalDay)
    };
    int response = await ChangeTicketRepository().createChangeTicket(body);
    return response;
  }

  //트레이너가 사용하는 변경 타입 change ticket 거절 메소드
  void rejectModifyTypeChangeTicket() async {
    final body = {
      'change_from': widget.requesterType,
      'change_type': widget.type,
      'status': ChangeTicketStatus.REJECTED,
      'change_reason': clicked == 0
          ? textController.text
          : widget.reasonContent.reasons[clicked],
      'reject_reason': clicked == 0
          ? textController.text
          : widget.reasonContent.reasons[clicked],
      'start_time': DateUtil.convertDatabaseFormatDateTime(widget.selectedDay!)
    };
    await ChangeTicketRepository()
        .modifyChangeTicket(widget.changeTicketId!, body);
  }

  //트레이너가 사용하는 취소 타입 change ticket 거절 메소드
  void rejectCancelTypeChangeTicket() async {
    final body = {
      'change_from': widget.requesterType,
      'change_type': widget.type,
      'status': ChangeTicketStatus.REJECTED,
      'change_reason': clicked == 0
          ? textController.text
          : widget.reasonContent.reasons[clicked],
      'reject_reason': clicked == 0
          ? textController.text
          : widget.reasonContent.reasons[clicked],
      'start_time': null,
    };
    await ChangeTicketRepository()
        .modifyChangeTicket(widget.changeTicketId!, body);
  }

  void moveToCompletePage(BuildContext context, int changeTicketId) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GymbieScheduleResolveTicket(
                type: widget.type,
                originDay: widget.scheduleDetail!.startTime,
                selectedDay: widget.selectedDay,
                selectedTime: widget.selectedTime,
                reason: clicked == 0
                    ? textController.text
                    : widget.reasonContent.reasons[clicked],
                changeTicketId: changeTicketId)));
  }
}
