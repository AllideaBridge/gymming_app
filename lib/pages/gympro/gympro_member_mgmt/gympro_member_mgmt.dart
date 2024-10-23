import 'package:flutter/material.dart';
import 'package:gymming_app/pages/gympro/gympro_member_mgmt/gympro_member_detail.dart';
import 'package:gymming_app/services/repositories/trainer_user_repository.dart';
import 'package:provider/provider.dart';

import '../../../common/colors.dart';
import '../../../services/models/trainer_user.dart';
import '../../../state/info_state.dart';

class GymproMemberMgmt extends StatefulWidget {
  final bool isPresent;

  const GymproMemberMgmt({
    super.key,
    required this.isPresent,
  });

  @override
  State<GymproMemberMgmt> createState() => _GymproMemberMgmtState();
}

class _GymproMemberMgmtState extends State<GymproMemberMgmt> {
  final TrainerUserRepository trainingUserRepository = TrainerUserRepository();
  late Future<List<TrainerUser>> trainingUserList;

  @override
  Widget build(BuildContext context) {
    refreshTrainerUserList(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        children: [
          buildSortButton(),
          FutureBuilder(
              future: trainingUserList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final trainingUserList = snapshot.data!;
                  return buildMemberList(context, trainingUserList);
                } else if (snapshot.hasError) {
                  return Text(
                    "${snapshot.error}",
                    style: TextStyle(color: Colors.white),
                  );
                }
                return const CircularProgressIndicator();
              })
        ],
      ),
    );
  }

  GestureDetector buildSortButton() {
    return GestureDetector(
      // TODO: 정렬 버튼 클릭 이벤트
      onTap: null,
      child: Row(
        children: [
          Text(
            '가나다 순',
            style: TextStyle(
              fontSize: 14.0,
              color: SECONDARY_COLOR,
            ),
          ),
          SizedBox(
            width: 4.0,
          ),
          Icon(
            Icons.sort,
            color: SECONDARY_COLOR,
            size: 16,
          ),
        ],
      ),
    );
  }

  Expanded buildMemberList(
      BuildContext context, List<TrainerUser> trainingUserList) {
    return Expanded(
      child: ListView.separated(
        itemCount: trainingUserList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GymproMemberDetail(
                          trainerId:
                              Provider.of<InfoState>(context, listen: false)
                                  .trainerId!,
                          userId: trainingUserList[index].userId,
                          isPresent: widget.isPresent)));
              setState(() {
                refreshTrainerUserList(context);
              });
            },
            child: Card(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: trainingUserList[index].userProfileImgUrl != null
                          ? Image.network(
                              trainingUserList[index].userProfileImgUrl!,
                              fit: BoxFit.cover,
                              width: 48.0,
                              height: 48.0,
                            )
                          : Image.asset(
                              'assets/images/user_example.png',
                              fit: BoxFit.cover,
                              width: 48.0,
                              height: 48.0,
                            ),
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(trainingUserList[index].userName,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          trainingUserList[index]
                              .getTrainerUserListDetailText(widget.isPresent),
                          style:
                              TextStyle(fontSize: 16.0, color: SECONDARY_COLOR),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: BORDER_COLOR,
            thickness: 1,
            height: 1,
          );
        },
      ),
    );
  }

  void refreshTrainerUserList(BuildContext context) {
    trainingUserList = trainingUserRepository.getTrainerUserList(
        Provider.of<InfoState>(context, listen: false).trainerId!,
        widget.isPresent);
  }
}
