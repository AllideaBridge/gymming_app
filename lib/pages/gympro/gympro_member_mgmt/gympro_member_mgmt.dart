import 'package:flutter/material.dart';
import 'package:gymming_app/pages/gympro/gympro_member_mgmt/gympro_member_detail.dart';
import 'package:gymming_app/services/models/trainee_list.dart';
import 'package:gymming_app/services/repositories/trainee_repository.dart';

import '../../../common/colors.dart';

class UserManagementList extends StatelessWidget {
  final String type;
  final List<TraineeList> traineeList = TraineeRepository().getTraineeList();

  UserManagementList({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        children: [
          GestureDetector(
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
          ),
          Expanded(
            child: ListView.separated(
              itemCount: traineeList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UserDetail()));
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
                              traineeList[index].profileImg,
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
                              Text(traineeList[index].name,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                type == 'now'
                                    ? '${traineeList[index].weekday} | ${traineeList[index].usedDay} / ${traineeList[index].totalDay} 진행 | ${traineeList[index].registeredDay} 등록'
                                    : '${traineeList[index].weekday} | ${traineeList[index].usedDay} / ${traineeList[index].totalDay} 진행 | ${traineeList[index].lastDay} 종료',
                                style: TextStyle(
                                    fontSize: 16.0, color: SECONDARY_COLOR),
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
          ),
        ],
      ),
    );
  }
}
