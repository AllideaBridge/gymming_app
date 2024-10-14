import 'package:flutter/material.dart';
import 'package:gymming_app/services/repositories/change_ticket_repository.dart';
import 'package:provider/provider.dart';

import '../../../common/colors.dart';
import '../../../components/cards/change_ticket_list_card.dart';
import '../../../services/models/change_ticket.dart';
import '../../../state/info_state.dart';
import 'gympro_request_detail.dart';

class GymproChangeTicketList extends StatefulWidget {
  final String changeTicketStatus;

  const GymproChangeTicketList({super.key, required this.changeTicketStatus});

  @override
  State<GymproChangeTicketList> createState() => _GymproChangeTicketListState();
}

class _GymproChangeTicketListState extends State<GymproChangeTicketList> {
  late Future<List<ChangeTicket>> _changeTicketList;
  late int trainerId;

  @override
  void initState() {
    super.initState();
    trainerId = Provider.of<InfoState>(context, listen: false).trainerId!;
    _changeTicketList = ChangeTicketRepository()
        .getTrainerChangeTicketList(trainerId, widget.changeTicketStatus, 1);
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
            onTap: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GymproRequestDetail(
                          changeTicket: changeTicketList[index])));
              setState(() {
                _changeTicketList = ChangeTicketRepository()
                    .getTrainerChangeTicketList(
                        trainerId, widget.changeTicketStatus, 1);
              });
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
