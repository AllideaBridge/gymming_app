import 'package:flutter/material.dart';

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
            DefaultTabController(
              length: 2,
              child: Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 37,
                      child: TabBar(
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
