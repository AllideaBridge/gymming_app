import 'package:flutter/material.dart';
import 'package:gymming_app/pages/gympro/gympro_member_mgmt/gympro_member_detail.dart';
import 'package:gymming_app/services/repositories/training_user_repository.dart';

import '../../../common/colors.dart';
import '../../../services/models/training_user.dart';

class UserManagementList extends StatefulWidget {
  final bool isPresent;

  UserManagementList({
    super.key,
    required this.isPresent,
  });

  @override
  State<UserManagementList> createState() => _UserManagementListState();
}

class _UserManagementListState extends State<UserManagementList> {
  final TrainingUserRepository trainingUserRepository =
      TrainingUserRepository();
  late Future<List<TrainingUser>> trainingUserList;

  @override
  Widget build(BuildContext context) {
    //todo trainerId 받아오기
    trainingUserList =
        trainingUserRepository.getTrainingUserList(1, widget.isPresent);

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
      BuildContext context, List<TrainingUser> trainingUserList) {
    return Expanded(
      child: ListView.separated(
        itemCount: trainingUserList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GymproMemberDetail()));
            },
            child: Card(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.asset(
                        trainingUserList[index].userProfileImgUrl,
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
                              .getTrainingUserListDetailText(widget.isPresent),
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
}
