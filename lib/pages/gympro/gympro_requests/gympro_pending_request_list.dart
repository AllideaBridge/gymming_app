import 'package:flutter/material.dart';
import 'package:gymming_app/pages/gympro/gympro_requests/gympro_request_detail.dart';
import 'package:gymming_app/services/repositories/request_repository.dart';

import '../../../common/colors.dart';
import '../../../common/constants.dart';
import '../../../services/models/request_list.dart';

class ResponseWaitingList extends StatelessWidget {
  final List<RequestList> requestList =
      RequestRepository().getPendingRequestList();

  @override
  Widget build(BuildContext context) {
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
                      requestList[index].profileImg,
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
                                  requestList[index].name,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  '${requestList[index].requestDay} 요청',
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
                                  requestList[index].originDay,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                SizedBox(width: 8.0),
                                Icon(Icons.arrow_forward_rounded,
                                    size: 12, color: Colors.white),
                                SizedBox(width: 8.0),
                                requestList[index].type == CHANGE
                                    ? Text(
                                        requestList[index].changeDay,
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
