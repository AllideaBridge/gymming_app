import 'package:flutter/material.dart';
import 'package:gymming_app/services/models/change_ticket.dart';
import 'package:provider/provider.dart';

import '../../../common/colors.dart';
import '../../../components/cards/change_ticket_list_card.dart';
import '../../../services/repositories/change_ticket_repository.dart';
import '../../../state/info_state.dart';
import 'gymbie_change_ticket_detail.dart';

class GymbieChangeTicketList extends StatefulWidget {
  final String changeTicketStatus;

  const GymbieChangeTicketList({super.key, required this.changeTicketStatus});

  @override
  State<GymbieChangeTicketList> createState() => _GymbieChangeTicketListState();
}

class _GymbieChangeTicketListState extends State<GymbieChangeTicketList> {
  late Future<List<ChangeTicket>> _changeTicketList;
  late int userId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userId = Provider.of<InfoState>(context, listen: false).userId!;
    _changeTicketList = _refreshData(userId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _changeTicketList,
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
            onTap: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GymbieChangeTicketDetail(
                          changeTicket: changeTicketList[index])));
              _refreshData(userId);
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

  Future<List<ChangeTicket>> _refreshData(userId) {
    return ChangeTicketRepository()
        .getUserChangeTicketList(userId, widget.changeTicketStatus, 1);
  }
}
