import 'package:flutter/material.dart';
import 'package:gymming_app/components/input_filed.dart';

class SamplePage extends StatelessWidget {
  const SamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            // 테스트할 컴포넌트를 아래 작성합니다.
            InputField(
              controller: controller,
              title: '샘플',
              isRequired: true,
            ),

            // 부모 위젯에서의 동작을 테스트하기 위한 버튼입니다.
            ElevatedButton(
              onPressed: () {
                // 버튼이 클릭되었을 때 실행할 코드를 여기에 작성합니다.
                print(controller.text);
              },
              child: Text('Sample Button'),
            ),
          ]),
        ),
      ),
    );
  }
}
