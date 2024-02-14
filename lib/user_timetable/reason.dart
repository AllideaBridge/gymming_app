import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gymming_app/common/component/common_header.dart';
import 'package:gymming_app/modal/model/reason_content.dart';
import 'package:gymming_app/user_timetable/schedule_change_complete_with_reason.dart';

import '../common/colors.dart';
import '../common/constants.dart';
import '../common/utils/toast_util.dart';

class Reason extends StatefulWidget {
  final ReasonContent reasonContent;
  final DateTime? originDay;
  final DateTime? selectedDay;
  final String? selectedTime;
  final String type;

  const Reason(
      {super.key,
      required this.reasonContent,
      this.originDay,
      this.selectedDay,
      this.selectedTime,
      required this.type});

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
              CommonHeader(
                  title:
                      widget.type != REJECT ? '일정 ${widget.type}' : '일정 변경 거절'),
              Container(
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
              ),
              Expanded(
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
                        padding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 12.0),
                        decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color:
                                      isOpen ? PRIMARY_COLOR : SECONDARY_COLOR,
                                  width: 2)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.reasonContent.reasons[clicked],
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                            isOpen
                                ? Image.asset('assets/icon_nav_arrow_up.png',
                                    width: 20, height: 20)
                                : Image.asset('assets/icon_nav_arrow_down.png',
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
                                      child: Text(
                                          widget.reasonContent.reasons[index],
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white))),
                                );
                              }),
                        ),
                      ),
                    if (widget.reasonContent.reasons[clicked] == '직접 입력' &&
                        !isOpen)
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
                                hintStyle: TextStyle(
                                    fontSize: 18, color: TERITARY_COLOR),
                                filled: true,
                                fillColor: BACKGROUND_COLOR,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                              ),
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            Positioned(
                              right: 16,
                              bottom: 12,
                              child: Text(
                                '$textLength / 100',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                width: 350,
                height: 56,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          widget.type == CANCEL ? Colors.white : PRIMARY_COLOR),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    onPressed: widget.type != REJECT
                        ? () {
                            // TODO: 변경&취소 API 호출
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ScheduleChangeCompleteWithReason(
                                          type: widget.type,
                                          originDay: widget.originDay!,
                                          selectedDay: widget.selectedDay!,
                                          selectedTime: widget.selectedTime!,
                                          reason: clicked == 0
                                              ? textController.text
                                              : widget.reasonContent
                                                  .reasons[clicked],
                                        )));
                          }
                        : () {
                            // TODO: 거절 API 호출
                            _showToast('운동 일정 변경을 거절하셨습니다.');
                            Navigator.pop(context);
                          },
                    child: Text(
                      "확인",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
