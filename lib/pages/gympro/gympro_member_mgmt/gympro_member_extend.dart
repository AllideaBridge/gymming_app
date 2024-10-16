import 'package:flutter/material.dart';
import 'package:gymming_app/common/colors.dart';
import 'package:gymming_app/components/common_header.dart';
import 'package:gymming_app/components/input_filed.dart';
import 'package:gymming_app/services/models/trainer_user_detail.dart';
import 'package:gymming_app/services/repositories/trainer_user_repository.dart';
import 'package:provider/provider.dart';

import '../../../state/info_state.dart';

class GymproMemberExtend extends StatefulWidget {
  final int userId;
  final TrainerUserDetail trainerUserDetail;

  const GymproMemberExtend(
      {super.key, required this.trainerUserDetail, required this.userId});

  @override
  State<StatefulWidget> createState() => _GymproMemberExtendState();
}

class _GymproMemberExtendState extends State<GymproMemberExtend> {
  final TextEditingController _countController = TextEditingController();
  late int _updateCurrentCount;
  late int _updateTotalCount;
  late bool _enableBtn = false;

  @override
  void initState() {
    super.initState();
    _updateCurrentCount = widget.trainerUserDetail.lessonCurrentCount;
    _updateTotalCount = widget.trainerUserDetail.lessonTotalCount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CommonHeader(
                title: '연장 등록',
                onPressed: () {
                  Navigator.pop(context);
                }),
            Expanded(
              child: SingleChildScrollView(
                child: _buildBody(),
              ),
            ),
            _buildButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputField(
            controller: _countController,
            title: '연장할 횟수',
            validator: (val) {
              if (val.length < 1) return '연장할 횟수는 필수값입니다.';
            },
            onValidationChanged: onChangedCount,
            isRequired: true,
          ),
          SizedBox(height: 16.0),
          Text(
            '남은 횟수',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              Text(
                widget.trainerUserDetail.lessonCurrentCount.toString(),
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8.0),
              Icon(Icons.arrow_forward, color: Colors.white, size: 24.0),
              SizedBox(width: 8.0),
              Text(
                _updateCurrentCount.toString(),
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: PRIMARY_COLOR,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Text(
            '총 횟수',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              Text(
                widget.trainerUserDetail.lessonTotalCount.toString(),
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8.0),
              Icon(Icons.arrow_forward, color: Colors.white, size: 24.0),
              SizedBox(width: 8.0),
              Text(
                _updateTotalCount.toString(),
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: PRIMARY_COLOR,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onChangedCount(bool isValid) {
    setState(() {
      int inputNumber = int.tryParse(_countController.text) ?? 0;
      _updateCurrentCount =
          widget.trainerUserDetail.lessonCurrentCount + inputNumber;
      _updateTotalCount =
          widget.trainerUserDetail.lessonTotalCount + inputNumber;

      if (_countController.text.isEmpty) {
        _enableBtn = false;
      } else {
        _enableBtn = true;
      }
    });
  }

  Widget _buildButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 40.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              _enableBtn ? PRIMARY_COLOR : PRIMARY_COLOR.withOpacity(0.3),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          minimumSize: const Size.fromHeight(56),
        ),
        onPressed: () {
          if (_enableBtn) {
            _updateCount();
          } else {
            null;
          }
        },
        child: Text(
          "연장 등록",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _updateCount() async {
    Map<String, dynamic> body = {
      'lesson_total_count': _updateCurrentCount,
      'lesson_current_count': _updateTotalCount,
      'exercise_days': widget.trainerUserDetail.exerciseDays,
      'special_notice': widget.trainerUserDetail.specialNotes,
    };
    await TrainerUserRepository().updateTrainerUser(
        Provider.of<InfoState>(context, listen: false).trainerId!,
        widget.userId,
        body);

    Navigator.pop(context);
  }
}
