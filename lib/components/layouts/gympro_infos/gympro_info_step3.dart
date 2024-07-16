import 'package:flutter/material.dart';
import 'package:gymming_app/common/colors.dart';

class GymproInfoStep3 extends StatefulWidget {
  const GymproInfoStep3({super.key});

  @override
  State<StatefulWidget> createState() => GymproInfoStep3State();
}

class GymproInfoStep3State extends State<GymproInfoStep3> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300.0,
      color: PRIMARY_COLOR,
      child:
          Text('Step3', style: TextStyle(fontSize: 40.0, color: Colors.white)),
    );
  }
}
