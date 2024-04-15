import 'package:flutter/material.dart';
import 'package:gymming_app/pages/gympro/gympro_requests/gympro_request_detail.dart';
import 'package:gymming_app/services/repositories/request_repository.dart';
import 'package:gymming_app/services/utils/date_util.dart';
import 'package:http/http.dart' as http;

import '../../../common/colors.dart';
import '../../../common/constants.dart';
import '../../../services/models/request_list.dart';

class GymproPendingRequestList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RequestRepository(client: http.Client())
          .getRequestList('1', 'WAITING'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}',
              style: TextStyle(color: Colors.white));
        } else {
          final requestList = snapshot.data!;
          return buildList(requestList);
        }
      },
    );
  }

  Widget buildList(List<RequestList> requestList) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: ListView.separated(
        itemCount: requestList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RequestDetail(
                            from: WAITING_LIST,
                          )));
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
                      requestList[index].userProfileImg,
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
                                  requestList[index].userName,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  '${DateUtil.convertDateTimeWithDot(requestList[index].createdAt)} 요청',
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
                                      requestList[index].scheduleStartTime),
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                SizedBox(width: 8.0),
                                Icon(Icons.arrow_forward_rounded,
                                    size: 12, color: Colors.white),
                                SizedBox(width: 8.0),
                                requestList[index].requestType == 'MODIFY'
                                    ? Text(
                                        DateUtil.convertKoreanWithoutWeek(
                                            requestList[index].requestTime),
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
