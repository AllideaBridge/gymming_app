import 'package:flutter/material.dart';
import 'package:gymming_app/pages/gymbie/explore/explore_detail.dart';
import 'package:gymming_app/pages/gymbie/gymbie_home/gymbie_home.dart';
import 'package:gymming_app/services/models/trainer_list.dart';
import 'package:gymming_app/services/repositories/trainer_repository.dart';

import '../../../common/colors.dart';

class ExploreScreen extends StatelessWidget {
  final List<TrainerList> trainers = TrainerRepository().getTrainerList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("둘러보기"),
          leading: const IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: null,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserTimeTable()));
              },
              style: ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(Colors.white)),
              child: Text('Timetable'),
            ),
            Image.asset('assets/images/arrow.png')
          ],
          backgroundColor: Colors.black,
        ),
        body: ListView.builder(
          itemCount: trainers.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ExploreDetail()));
                },
                child: TrainerTile(trainer: trainers[index]));
          },
        ));
  }
}

class TrainerTile extends StatelessWidget {
  final TrainerList trainer;
  late String displayTime = trainer.weekendTime == ''
      ? '평일 ${trainer.weekdayTime}'
      : '평일 ${trainer.weekdayTime}\n주말 ${trainer.weekendTime}';

  TrainerTile({required this.trainer});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: BORDER_COLOR))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(trainer.profileImg,
                width: 88, height: 88, fit: BoxFit.cover),
            const SizedBox(
              width: 16,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text(trainer.name,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  width: 8,
                ),
                Text(trainer.position,
                    style:
                        const TextStyle(fontSize: 14, color: SECONDARY_COLOR))
              ]),
              const SizedBox(
                height: 6,
              ),
              Text('${trainer.location} | ${trainer.centerName}',
                  style: const TextStyle(fontSize: 14, color: Colors.white)),
              const SizedBox(
                height: 6,
              ),
              Text(displayTime,
                  style: const TextStyle(fontSize: 14, color: Colors.white))
            ])
          ],
        ));
  }
}
