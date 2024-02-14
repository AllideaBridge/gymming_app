import 'package:flutter/material.dart';
import 'package:gymming_app/common/component/common_header.dart';
import 'package:gymming_app/modal/model/reason_content.dart';
import 'package:gymming_app/user_timetable/schedule_change_complete_with_reason.dart';

import '../common/colors.dart';

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

  bool isOpen = false;
  int clicked = 0;
  int textLength = 0;

  @override
  void initState() {
    super.initState();

    textController.addListener(() {
      setState(() {
        textLength = textController.text.length;
      });
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
              CommonHeader(title: '일정 ${widget.type}'),
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
                            border: Border.all(color: BRIGHT_SECONDARY_COLOR),
                            borderRadius: BorderRadius.circular(4),
                            color: BTN_COLOR),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.reasonContent.reasons[clicked],
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)),
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
                        height: 207,
                        padding: EdgeInsets.fromLTRB(16, 6, 16, 6),
                        decoration: BoxDecoration(
                            border: Border.all(color: BRIGHT_SECONDARY_COLOR),
                            borderRadius: BorderRadius.circular(4),
                            color: BTN_COLOR),
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
                                          vertical: 10, horizontal: 0),
                                      child: Text(
                                          widget.reasonContent.reasons[index],
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white))),
                                );
                              }),
                        ),
                      ),
                    if (clicked == 0 && !isOpen)
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
                                    fontSize: 16, color: Colors.white),
                                filled: true,
                                fillColor: BTN_COLOR,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                              ),
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
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
                      backgroundColor:
                          MaterialStateProperty.all<Color>(BTN_COLOR),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ScheduleChangeCompleteWithReason(
                                    type: widget.type,
                                    originDay: widget.originDay,
                                    selectedDay: widget.selectedDay,
                                    selectedTime: widget.selectedTime,
                                    reason: clicked == 0
                                        ? textController.text
                                        : widget.reasonContent.reasons[clicked],
                                  )));
                    },
                    child: Text(
                      "확인",
                      style: TextStyle(
                        fontSize: 18,
                        color: PRIMARY_COLOR,
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
