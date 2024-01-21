import 'package:flutter/material.dart';
import 'package:gymming_app/common/colors.dart';
import 'package:gymming_app/common/component/buttons/primary_button.dart';
import 'package:gymming_app/common/component/buttons/secondary_button.dart';
import 'package:gymming_app/common/component/common_header.dart';
import 'package:gymming_app/common/component/icon_label.dart';

import '../models/request_list.dart';

class RequestDetail extends StatefulWidget {
  final String from;

  //dummy instance
  final RequestList requestDetail = RequestList(
      profileImg: 'img',
      name: '김민희',
      originDay: '8월 6일 목 09:00',
      changeDay: '8월 7일 금 20:00',
      requestDay: '23. 10. 08. 16:07 요청');

  RequestDetail({super.key, required this.from});

  @override
  _RequestDetailState createState() => _RequestDetailState();
}

class _RequestDetailState extends State<RequestDetail> {
  bool _isCompleted = false;
  bool _isAccepted = false;

  @override
  Widget build(BuildContext context) {
    RequestList requestDetail = widget.requestDetail;

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
                        Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
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
                                  requestDetail.name,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.white,
                                  size: 16,
                                )
                              ],
                            ),
                            Text(
                              requestDetail.requestDay,
                              style: TextStyle(
                                  fontSize: 14, color: SECONDARY_COLOR),
                            )
                          ],
                        )
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {},
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
            Padding(
              padding: EdgeInsets.fromLTRB(20, 28, 20, 0),
              child: Visibility(
                  visible: _isCompleted,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Visibility(
                          visible: _isAccepted,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: PRIMARY2_COLOR,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Text(
                              '승인',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          )),
                  Visibility(
                    visible: !_isAccepted,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: BTN_COLOR,
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Text(
                          '거절',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ))
                    ],
                  )),
            ),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 28, horizontal: 20),
                    child: Column(
                      children: [
                        IconLabel(
                            iconData: Icons.alarm,
                            title: '변경 전',
                            content: requestDetail.originDay,
                            titleColor: SECONDARY_COLOR,
                            contentColor: SECONDARY_COLOR),
                        SizedBox(
                          height: 40,
                        ),
                        IconLabel(
                            iconData: Icons.alarm,
                            title: '변경 후',
                            content: requestDetail.changeDay,
                            titleColor: Colors.white,
                            contentColor: Colors.white),
                        SizedBox(
                          height: 40,
                        ),
                        IconLabel(
                            iconData: Icons.message_outlined,
                            title: '변경 사유',
                            content: '잘못된 날을 선택하였습니다.',
                            titleColor: Colors.white,
                            contentColor: Colors.white),
                      ],
                    ))),
            Visibility(
                visible: !_isCompleted,
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                    child: SizedBox(
                        height: 56,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SecondaryButton(
                                title: '거절',
                                onPressed: () {
                                  setState(() {
                                    _isCompleted = true;
                                    _isAccepted = false;
                                  });
                                }),
                            SizedBox(width: 12),
                            PrimaryButton(
                              title: '승인',
                              onPressed: () {
                                setState(() {
                                  _isCompleted = true;
                                  _isAccepted = true;
                                });
                              },
                            )
                          ],
                        ))))
          ],
        ),
      ),
    );
  }
}
