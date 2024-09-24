import 'package:flutter/material.dart';
import 'package:gymming_app/services/repositories/change_ticket_repository.dart';

import '../../../common/colors.dart';
import '../../../components/cards/change_ticket_list_card.dart';
import '../../../services/models/change_ticket.dart';
import 'gympro_request_detail.dart';

class GymproChangeTicketList extends StatelessWidget {
  final String changeTicketStatus;

  const GymproChangeTicketList({super.key, required this.changeTicketStatus});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // TODO TrainerId 로그인된 값으로 변경
      // TODO Status 값(WAITING) 상수화
      // TODO 무한 스크롤 page 늘어나는 기능 구현
      future: ChangeTicketRepository()
          .getTrainerChangeTicketList(1, changeTicketStatus, 1),
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
            child: ChangeTicketListCard(
              title: changeTicketList[index].userName!,
              changeTicket: changeTicketList[index],
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
