import 'package:flutter/material.dart';
import 'package:gymming_app/pages/gympro/gympro_home/gympro_home.dart';
import 'package:gymming_app/services/repositories/trainer_user_repository.dart';

import '../../common/colors.dart';

class GymproGymbieDelete extends StatelessWidget {
  final String name;
  final int trainerId;
  final int userId;

  const GymproGymbieDelete(
      {required this.name,
      super.key,
      required this.trainerId,
      required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: PRIMARY_COLOR,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "님을",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                "정말 삭제하시겠어요?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                "삭제한 회원은 목록에서 사라지며,\n복구가 불가능합니다.",
                style:
                    TextStyle(color: Colors.white, fontSize: 16, height: 1.6),
              ),
              Expanded(child: SizedBox()),
              Center(
                child: SizedBox(
                  width: 350,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      TrainerUserRepository()
                          .deleteTrainerUser(trainerId, userId);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => GymproHome()),
                          (Route<dynamic> route) => false);
                    },
                    style: ButtonStyle(
                      side: WidgetStateProperty.all(
                          BorderSide(color: TERITARY_COLOR, width: 1.5)),
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.black),
                      shape: WidgetStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    child: Text(
                      '삭제',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Center(
                child: SizedBox(
                  width: 350,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.white),
                      shape: WidgetStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    child: Text(
                      '프로필로 복귀',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
