import 'package:flutter/material.dart';

import '../../common/colors.dart';
import '../../services/models/change_ticket.dart';
import '../../services/utils/date_util.dart';
import '../chips/grey_chip.dart';
import '../chips/primary_chip.dart';

class ChangeTicketListCard extends StatelessWidget {
  final String title;
  final ChangeTicket changeTicket;

  const ChangeTicketListCard(
      {super.key, required this.title, required this.changeTicket});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          '${DateUtil.convertDateTimeWithDot(changeTicket.createdAt)} 요청',
                          style:
                              TextStyle(fontSize: 14, color: SECONDARY_COLOR),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          DateUtil.convertKoreanWithoutWeek(
                              changeTicket.asIsDate),
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        SizedBox(width: 8.0),
                        Icon(Icons.arrow_forward_rounded,
                            size: 12, color: Colors.white),
                        SizedBox(width: 8.0),
                        changeTicket.changeTicketType == 'MODIFY'
                            ? Text(
                                DateUtil.convertKoreanWithoutWeek(
                                    changeTicket.toBeDate!),
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              )
                            : Text(
                                '취소',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              )
                      ],
                    ),
                  ],
                ),
                getChangeTicketRightSide()
              ],
            ),
          ),
        ],
      ),
    );
  }

  StatelessWidget getChangeTicketRightSide() {
    if (changeTicket.changeTicketStatus == 'WAITING') {
      return Icon(Icons.keyboard_arrow_right_rounded,
          size: 24, color: BORDER_COLOR);
    }

    if (changeTicket.changeTicketStatus == 'APPROVED') {
      return PrimaryChip(title: '승인');
    }
    return GreyChip(title: '거절');
  }
}
