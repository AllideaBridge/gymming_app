import 'package:flutter/material.dart';
import 'package:gymming_app/common/colors.dart';

import 'common_header.dart';

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
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Column(
          children: [
            CommonHeader(title: title),
            // TODO: 간격 조정 필요
            SizedBox(height: 10),
            DefaultTabController(
              length: 2,
              child: Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 38,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: BORDER_COLOR,
                        width: 1.0,
                      ))),
                      child: TabBar(
                        labelColor: PRIMARY_COLOR,
                        unselectedLabelColor: TERITARY_COLOR,
                        labelStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        unselectedLabelStyle: TextStyle(
                          fontSize: 18,
                        ),
                        indicatorColor: PRIMARY_COLOR,
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs: [
                          Tab(text: leftTabName),
                          Tab(text: rightTabName),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [leftComponent, rightComponent],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
