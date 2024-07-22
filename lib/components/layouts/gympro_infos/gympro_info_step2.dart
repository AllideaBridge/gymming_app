import 'package:flutter/material.dart';
import 'package:gymming_app/components/available_time.dart';
import 'package:gymming_app/components/input_filed.dart';
import 'package:gymming_app/components/text_dropdown.dart';

class GymproInfoStep2 extends StatefulWidget {
  final Function onChanged;
  final Map<String, dynamic>? originModel;

  const GymproInfoStep2({super.key, required this.onChanged, this.originModel});

  @override
  State<StatefulWidget> createState() => GymproInfoStep2State();
}

class GymproInfoStep2State extends State<GymproInfoStep2> {
  final TextEditingController _lessonNameController = TextEditingController();
  final TextEditingController _lessonCostController = TextEditingController();

  late Map<String, dynamic> _model = {
    'lessonName': '',
    'lessonCost': '',
    'lessonTime': null,
    'lessonTimeType': null,
    'lessonPossibleTime': null,
  };

  @override
  void initState() {
    super.initState();

    if (widget.originModel != null) {
      setState(() {
        _model = widget.originModel!;
        _lessonNameController.text = _model['lessonName'];
        _lessonCostController.text = _model['lessonCost'];
      });
    }
  }

  @override
  void dispose() {
    _lessonNameController.dispose();
    _lessonCostController.dispose();
    super.dispose();
  }

  void onChangedLessonName() {
    setState(() {
      _model['lessonName'] = _lessonNameController.text;
    });
    widget.onChanged(_model);
  }

  void onChangedLessonCost() {
    setState(() {
      _model['lessonCost'] = _lessonCostController.text;
    });
    widget.onChanged(_model);
  }

  void onChangedLessonTime(String time) {
    setState(() {
      _model['lessonTime'] = time;
    });
    widget.onChanged(_model);
  }

  void onChangedLessonTimeType(String timeType) {
    setState(() {
      _model['lessonTimeType'] = timeType;
    });
    widget.onChanged(_model);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            InputField(
              controller: _lessonNameController,
              title: '수업명',
              validator: (val) {
                if (val.length < 1) return '수업명은 필수값입니다.';
              },
              onValidationChanged: onChangedLessonName,
              isRequired: true,
            ),
            SizedBox(height: 60.0),
            InputField(
              controller: _lessonCostController,
              title: '수업 가격(회당)',
              validator: (val) {
                if (val.length < 1) return '수업 가격은 필수값입니다.';
              },
              onValidationChanged: onChangedLessonCost,
              isRequired: true,
              placeHolder: '원(￦) 단위로 입력하세요.',
            ),
            SizedBox(height: 60.0),
            TextDropdown(
              title: '수업 시간',
              isRequired: true,
              originValue: _model['lessonTime'] ?? '',
              dropdownItems: ['30분', '1시간', '1시간 30분', '2시간', '2시간 30분', '3시간'],
              setter: onChangedLessonTime,
            ),
            SizedBox(height: 60.0),
            TextDropdown(
              title: '수업 가능한 시간',
              isRequired: true,
              dropdownItems: ['매일', '평일/주말', '모두 입력'],
              setter: onChangedLessonTimeType,
            ),
            SizedBox(height: 32.0),
            _buildAvailableTime(),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailableTime() {
    if (_model['lessonTimeType'] == '매일') {
      return AvailableTime(availableTime: [
        {'title': '매일', 'start': '', 'end': '', 'isChecked': true},
      ]);
    } else if (_model['lessonTimeType'] == '평일/주말') {
      return AvailableTime(availableTime: [
        {'title': '평일', 'start': '', 'end': '', 'isChecked': true},
        {'title': '주말', 'start': '', 'end': '', 'isChecked': true},
      ]);
    } else if (_model['lessonTimeType'] == '모두 입력') {
      return AvailableTime(availableTime: [
        {'title': '월', 'start': '', 'end': '', 'isChecked': true},
        {'title': '화', 'start': '', 'end': '', 'isChecked': true},
        {'title': '수', 'start': '', 'end': '', 'isChecked': true},
        {'title': '목', 'start': '', 'end': '', 'isChecked': true},
        {'title': '금', 'start': '', 'end': '', 'isChecked': true},
      ]);
    }
    return SizedBox();
  }
}
