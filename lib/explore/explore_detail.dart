import 'package:flutter/material.dart';
import 'package:gymming_app/explore/component/profile_text.dart';
import 'package:gymming_app/repositories/trainer_repository.dart';

import '../models/trainer_detail.dart';
import 'component/profile_img.dart';

class ExploreDetail extends StatelessWidget {
  final TrainerDetail trainerDetail = TrainerRepository().getTrainerDetail();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: SafeArea(
            child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Image.asset(
                            'assets/icon_nav_arrow_left.png',
                            height: 24,
                            width: 24,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        const Text('상세 정보',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(
                          width: 24,
                          height: 24,
                        ),
                      ]),
                  SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProfileImg(imgList: trainerDetail.profileImgList),
                              ProfileText(trainerDetail)
                            ]),
                      ),
                    ),
                  )
                ]))));
  }
}
