import 'package:flutter/material.dart';

import 'component/completed_list.dart';
import 'component/response_waiting_list.dart';

class Request extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: '응답 대기'),
                Tab(text: '완료'),
              ],
            ),
            title: Text('요청 목록'),
            centerTitle: true,
            backgroundColor: Colors.black,
          ),
          body: TabBarView(
            children: [
              // 응답 대기 탭 컨텐츠
              ResponseWaitingList(),
              // 완료 탭 컨텐츠
              CompletedList(),
            ],
          ),
        ),
      ),
    );
  }
}

