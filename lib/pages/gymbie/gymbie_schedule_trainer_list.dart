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
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: FutureBuilder(
                    future:
                        TrainerUserRepository().getTrainersListOfUser(userId),
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
                ),
              )
            ],
          ),
        ));
  }

  Widget buildList(List<TrainerList> trainerList) {
    return ListView.builder(
        itemCount: trainerList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: Card(
              child: buildTrainerTile(trainerList[index]),
            ),
          );
        });
  }

  Widget buildTrainerTile(TrainerList trainer) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: BORDER_COLOR))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(trainer.trainerProfileImgUrl,
                width: 88, height: 88, fit: BoxFit.cover),
            const SizedBox(
              width: 16,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                    style:
                        const TextStyle(fontSize: 14, color: SECONDARY_COLOR))
              ]),
              const SizedBox(
                height: 6,
              ),
              Text('${trainer.centerLocation} | ${trainer.centerName}',
                  style: const TextStyle(fontSize: 14, color: Colors.white)),
              const SizedBox(
                height: 6,
              ),
              Text(trainer.lessonCurrentCount.toString())
            ])
          ],
        ));
  }
}
