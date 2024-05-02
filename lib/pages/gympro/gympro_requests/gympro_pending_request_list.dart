import 'package:flutter/material.dart';
import 'package:gymming_app/pages/gympro/gympro_requests/gympro_request_detail.dart';
import 'package:gymming_app/services/repositories/change_ticket_repository.dart';
import 'package:gymming_app/services/utils/date_util.dart';
import 'package:http/http.dart' as http;

import '../../../common/colors.dart';
import '../../../services/models/change_ticket.dart';

class GymproPendingRequestList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // TODO TrainerId 로그인된 값으로 변경
      // TODO Status 값(WAITING) 상수화
      // TODO 무한 스크롤 page 늘어나는 기능 구현
      future: ChangeTicketRepository(client: http.Client())
          .getChangeTicketList(1, 'WAITING', 1),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}',
              style: TextStyle(color: Colors.white));
        } else {
          final changeTicketList = snapshot.data!;
          return buildList(changeTicketList);
        }
      },
    );
  }

  Widget buildList(List<ChangeTicket> changeTicketList) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: ListView.separated(
        itemCount: changeTicketList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GymproRequestDetail(
                          changeTicket: changeTicketList[index])));
            },
            child: Card(
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.asset(
                      changeTicketList[index].userProfileImage,
                      fit: BoxFit.cover,
                      width: 32.0,
                      height: 32.0,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  changeTicketList[index].userName,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  '${DateUtil.convertDateTimeWithDot(changeTicketList[index].createdAt)} 요청',
                                  style: TextStyle(
                                      fontSize: 14, color: SECONDARY_COLOR),
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
                                      changeTicketList[index].asIsDate),
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                SizedBox(width: 8.0),
                                Icon(Icons.arrow_forward_rounded,
                                    size: 12, color: Colors.white),
                                SizedBox(width: 8.0),
                                changeTicketList[index].requestType == 'MODIFY'
                                    ? Text(
                                        DateUtil.convertKoreanWithoutWeek(
                                            changeTicketList[index].toBeDate),
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
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 20,
                          color: BORDER_COLOR,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: BORDER_COLOR,
            thickness: 1,
            height: 32.0,
          );
        },
      ),
    );
  }
}
