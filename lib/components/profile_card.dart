import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../common/colors.dart';

class ProfileCard extends StatelessWidget {
  final String? imgUrl;
  final String name;
  final DateTime birth;
  final String gender;
  final String phoneNumber;
  final String? additionalTitle;
  final List<Widget>? additionalSub;

  const ProfileCard({
    super.key,
    required this.imgUrl,
    required this.name,
    required this.birth,
    required this.gender,
    required this.phoneNumber,
    this.additionalTitle,
    this.additionalSub,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      _buildChildrenBasicWidget(),
    ];
    if (additionalTitle != null && additionalSub != null) {
      children.add(Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        width: double.infinity,
        height: 2.0,
        color: Colors.white,
      ));
      children.add(_buildChildrenAdditionalWidget());
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: CARD_BACK_GROUD_COLOR,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildChildrenBasicWidget() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: imgUrl != null
              ? Image.asset(
                  imgUrl!,
                  fit: BoxFit.cover,
                  width: 80.0,
                  height: 80.0,
                )
              : Container(
                  color: TERITARY_COLOR,
                  width: 80.0,
                  height: 80.0,
                ),
        ),
        SizedBox(width: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  DateFormat('yyyy.MM.dd').format(birth),
                  style: TextStyle(
                    fontSize: 16.0,
                    color: BRIGHT_SECONDARY_COLOR,
                  ),
                ),
                Container(
                  width: 2.0,
                  height: 16.0,
                  color: BRIGHT_SECONDARY_COLOR,
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                ),
                Text(
                  gender,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: BRIGHT_SECONDARY_COLOR,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              phoneNumber,
              style: TextStyle(
                fontSize: 16.0,
                color: BRIGHT_SECONDARY_COLOR,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChildrenAdditionalWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildAdditionalWidgetWithSpacing(),
    );
  }

  List<Widget> _buildAdditionalWidgetWithSpacing() {
    List<Widget> additionalWidgets = [
      Text(
        additionalTitle!,
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      SizedBox(height: 8.0),
    ];
    for (int i = 0; i < additionalSub!.length; i++) {
      additionalWidgets.add(additionalSub![i]);
      if (i < additionalSub!.length - 1) {
        additionalWidgets.add(SizedBox(height: 8.0));
      }
    }
    return additionalWidgets;
  }
}
