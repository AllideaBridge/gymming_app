import 'package:flutter/material.dart';
import 'package:gymming_app/components/common_header.dart';
import 'package:gymming_app/services/models/trainer_list.dart';
import 'package:gymming_app/services/repositories/trainer_user_repository.dart';

import '../../common/colors.dart';

class GymbieScheduleTrainerList extends StatelessWidget {
  final int userId;

  const GymbieScheduleTrainerList({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: SafeArea(
          child: Column(
            children: [
              CommonHeader(title: '일정 추가'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FutureBuilder(
                  future: TrainerUserRepository().getTrainersListOfUser(userId),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<TrainerList>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}',
                          style: TextStyle(color: Colors.white));
                    } else {
                      final trainerList = snapshot.data!;
                      return buildList(trainerList);
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }

  Widget buildList(List<TrainerList> trainerList) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: trainerList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (trainerList[index].lessonRemainCount != 0) {
                //실제 로직
              }
            },
            child: buildTrainerTile(trainerList[index]),
          );
        });
  }

  Widget buildTrainerTile(TrainerList trainer) {
    return Opacity(
      opacity: trainer.lessonRemainCount == 0 ? 0.5 : 1,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: BORDER_COLOR,
          width: 1.0,
        ))),
        child: Card(
          color: Colors.black,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(44),
                child: Image.asset(
                  trainer.trainerProfileImgUrl,
                  width: 88,
                  height: 88,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Flexible(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Text(trainer.trainerName,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(trainer.centerLocation,
                            style: const TextStyle(
                              fontSize: 14,
                              color: SECONDARY_COLOR,
                            ))
                      ]),
                      const SizedBox(
                        height: 2,
                      ),
                      Text("레슨명 안들어옴",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 2,
                      ),
                      Text('${trainer.centerLocation} | ${trainer.centerName}',
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              overflow: TextOverflow.ellipsis)),
                      const SizedBox(
                        height: 2,
                      ),
                      Text('남은 수업 횟수: ${trainer.lessonRemainCount.toString()}',
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              overflow: TextOverflow.ellipsis))
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
