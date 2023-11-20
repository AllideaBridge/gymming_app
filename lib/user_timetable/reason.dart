import 'package:flutter/material.dart';
import 'package:gymming_app/common/colors.dart';
import 'package:gymming_app/common/constants.dart';
import 'package:gymming_app/modal/model/reason_content.dart';
import 'package:gymming_app/user_timetable/component/schedule_header.dart';
import 'package:gymming_app/user_timetable/proposal.dart';

class Reason extends StatefulWidget {
  final ReasonContent reasonContent;
  final DateTime originDay;
  final DateTime selectedDay;
  final String selectedTime;
  final String type;

  const Reason(
      {super.key,
      required this.reasonContent,
      required this.originDay,
      required this.selectedDay,
      required this.selectedTime,
      required this.type});

  @override
  ReasonState createState() => ReasonState();
}

class ReasonState extends State<Reason> {
  final textController = TextEditingController();

  bool isOpen = false;
  int clicked = 0;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true,
      body: SafeArea(
        child: Container(
          color: BACKGROUND_COLOR,
          constraints: BoxConstraints.expand(),
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ScheduleHeader(type: widget.type),
                Text(widget.reasonContent.title,
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                Text(widget.reasonContent.subtitle,
                    style: TextStyle(fontSize: 15, color: Colors.white)),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isOpen = !isOpen;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                        color: BORDER_COLOR),
                    margin: EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.reasonContent.reasons[clicked],
                                style: TextStyle(color: Colors.white)),
                            Icon(
                              isOpen
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        if (isOpen) ...[
                          Divider(),
                          ...widget.reasonContent.reasons
                              .asMap()
                              .entries
                              .map((e) {
                            var idx = e.key;
                            var reason = e.value;

                            return TextButton(
                              onPressed: () {
                                setState(() {
                                  clicked = idx;
                                  isOpen = !isOpen;
                                });
                                print(clicked);
                              },
                              child: Text(reason),
                            );
                          }).toList(),
                        ],
                      ],
                    ),
                  ),
                ),
                if (clicked == 0)
                  TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: '텍스트를 입력하세요',
                      hintStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: BORDER_COLOR,
                      // 필요에 따라 배경색을 조절할 수 있습니다.
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SECONDARY_COLOR, // Right Button Color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Proposal(
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
                        color: Colors.greenAccent,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
