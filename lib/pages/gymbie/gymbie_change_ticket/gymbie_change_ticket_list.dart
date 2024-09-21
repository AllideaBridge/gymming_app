import 'package:flutter/material.dart';
import 'package:gymming_app/services/models/change_ticket.dart';
import 'package:http/http.dart' as http;

import '../../../common/colors.dart';
import '../../../components/cards/change_ticket_list_card.dart';
import '../../../services/repositories/change_ticket_repository.dart';
import 'gymbie_change_ticket_detail.dart';

class GymbieChangeTicketList extends StatelessWidget {
  final String changeTicketStatus;

  const GymbieChangeTicketList({super.key, required this.changeTicketStatus});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ChangeTicketRepository(client: http.Client())
            .getUserChangeTicketList(1, changeTicketStatus, 1),
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
        });
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
                      builder: (context) => GymbieChangeTicketDetail(
                          changeTicket: changeTicketList[index])));
            },
            child: ChangeTicketListCard(
              title: changeTicketList[index].trainerName!,
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
