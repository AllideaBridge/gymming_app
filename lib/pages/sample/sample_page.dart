import 'package:flutter/material.dart';
import 'package:gymming_app/components/available_time.dart';
import 'package:gymming_app/components/input_filed.dart';
import 'package:gymming_app/components/profile_image.dart';

class SamplePage extends StatefulWidget {
  const SamplePage({super.key});

  @override
  State<SamplePage> createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  final TextEditingController _controller = TextEditingController();
  bool _isValid = false;
  List<Map<String, dynamic>> availableTimeList = [];

  @override
  void initState() {
    super.initState();
    availableTimeList = [
      {'title': '평일', 'start': '', 'end': '', 'isChecked': true},
      {'title': '주말', 'start': '', 'end': '', 'isChecked': true},
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void handleValidationChanged(bool isValid) {
    setState(() {
      _isValid = isValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            // 이미지 테스트를 위한 코드입니다.
            ProfileImage(size: 200.0),
            // 테스트할 컴포넌트를 아래 작성합니다.
            InputField(
              controller: _controller,
              title: '이름',
              validator: (val) {
                if (val.length < 1) return '이름은 필수값입니다.';
              },
              onValidationChanged: handleValidationChanged,
            ),
            AvailableTime(
              availableTime: availableTimeList,
            ),
            // 부모 위젯에서의 동작을 테스트하기 위한 버튼입니다.
            ElevatedButton(
              onPressed: () {
                // 버튼이 클릭되었을 때 실행할 코드를 여기에 작성합니다.
                setState(() {
                  availableTimeList = [
                    {'title': '월', 'start': '', 'end': '', 'isChecked': true},
                    {'title': '화', 'start': '', 'end': '', 'isChecked': true},
                    {'title': '수', 'start': '', 'end': '', 'isChecked': true},
                    {'title': '목', 'start': '', 'end': '', 'isChecked': true},
                    {'title': '금', 'start': '', 'end': '', 'isChecked': true},
                    {'title': '토', 'start': '', 'end': '', 'isChecked': true},
                    {'title': '일', 'start': '', 'end': '', 'isChecked': true},
                  ];
                });
              },
              child: _isValid ? Text('valid true') : Text('valid false'),
            ),
          ]),
        ),
      ),
    );
  }
}
