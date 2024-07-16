import 'package:flutter/material.dart';
import 'package:gymming_app/common/colors.dart';

class GymproInfoStep2 extends StatefulWidget {
  const GymproInfoStep2({super.key});

  @override
  State<StatefulWidget> createState() => GymproInfoStep2State();
}

class GymproInfoStep2State extends State<GymproInfoStep2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300.0,
      color: PRIMARY_COLOR,
      child:
          Text('Step2', style: TextStyle(fontSize: 40.0, color: Colors.white)),
    );
  }
}
