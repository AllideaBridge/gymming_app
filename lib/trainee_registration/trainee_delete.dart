import 'package:flutter/material.dart';

import '../common/colors.dart';

class TraineeDelete extends StatelessWidget {
  final String name;

  const TraineeDelete({ required this.name, super.key});

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
                  Text(name, style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),),
                  SizedBox(width: 4,),
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
              SizedBox(height: 2,),
              Text(
                "정말 삭제하시겠어요?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
              SizedBox(height: 12,),
              Text("삭제한 회원은 목록에서 사라지며,\n복구가 불가능합니다.", style: TextStyle(color: Colors.white, fontSize: 16, height: 1.6),),
              Expanded(child: SizedBox()),
              Center(
                child: SizedBox(
                  width: 350,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      //TODO 삭제 api 발송 후 회원관리 목록으로 이동
                    },
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                        BorderSide(color: TERITARY_COLOR, width: 1.5)
                      ),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
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
              SizedBox(height: 12,),
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
                      MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
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