import 'package:flutter/material.dart';

import '../../user_request/component/completed_list.dart';
import '../../user_request/component/response_waiting_list.dart';

class Request extends StatelessWidget {
  const Request(
      {super.key,
      required this.title,
      required this.leftTabName,
      required this.rightTabName,
      required this.leftComponent,
      required this.rightComponent});

  final String title;
  final String leftTabName;
  final String rightTabName;
  final dynamic leftComponent;
  final dynamic rightComponent;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: leftTabName),
                Tab(text: rightTabName),
              ],
            ),
            title: Text(title),
            centerTitle: true,
            backgroundColor: Colors.black,
          ),
          body: TabBarView(
            children: [
              // 응답 대기 탭 컨텐츠
              leftComponent,
              // 완료 탭 컨텐츠
              rightComponent,
            ],
          ),
        ),
      ),
    );
  }
}
