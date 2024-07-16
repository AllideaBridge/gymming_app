import 'package:flutter/material.dart';

class GymproInfoStep1 extends StatefulWidget {
  const GymproInfoStep1({super.key});

  @override
  State<StatefulWidget> createState() => GymproInfoStep1State();
}

class GymproInfoStep1State extends State<GymproInfoStep1> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(height: 300.0, color: Colors.white),
          SizedBox(height: 12.0),
          Container(height: 300.0, color: Colors.white),
          SizedBox(height: 12.0),
          Container(height: 300.0, color: Colors.white),
        ],
      ),
    );
  }
}
