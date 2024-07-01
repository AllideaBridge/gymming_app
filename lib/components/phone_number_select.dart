import 'package:flutter/material.dart';
import 'package:gymming_app/components/text_dropdown.dart';

import '../common/colors.dart';
import '../common/constants.dart';

class PhoneNumberSelect extends StatefulWidget {
  const PhoneNumberSelect(
      {super.key,
      required this.title,
      required this.setter,
      this.originalNumber});

  final String title;
  final Function setter;
  final String? originalNumber;

  @override
  State<StatefulWidget> createState() => _PhoneNumberSelectState();
}

class _PhoneNumberSelectState extends State<PhoneNumberSelect> {
  final FocusNode _middleFocusNode = FocusNode();
  final FocusNode _endFocusNode = FocusNode();
  final TextEditingController _middleNumberController = TextEditingController();
  final TextEditingController _endNumberController = TextEditingController();
  String _firstNumber = "";

  @override
  void initState() {
    super.initState();
    if (widget.originalNumber != null) {
      _firstNumber = widget.originalNumber!.split("-")[0];
      _middleNumberController.text = widget.originalNumber!.split("-")[1];
      _endNumberController.text = widget.originalNumber!.split("-")[2];
    }
  }

  @override
  void dispose() {
    _middleFocusNode.dispose();
    _endFocusNode.dispose();
    super.dispose();
  }

  void getFirstNumbers(String result) {
    _firstNumber = result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Row(
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  '*',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: PRIMARY2_COLOR),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            )
          ],
        ),
        Row(
          children: [
            TextDropdown(
              placeholder: '010',
              dropdownItems: FIRST_NUMBERS,
              setter: getFirstNumbers,
              dropdownWidth: 92.0,
              originValue: _firstNumber,
            ),
            SizedBox(width: 12),
            Container(
              width: 8,
              height: 2,
              color: SECONDARY_COLOR,
            ),
            SizedBox(width: 12),
            SizedBox(
              width: 97,
              height: 50,
              child: TextField(
                controller: _middleNumberController,
                focusNode: _middleFocusNode,
                style: TextStyle(
                  color: Colors.white,
                ),
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "1234",
                  hintStyle: TextStyle(color: TERITARY_COLOR),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: SECONDARY_COLOR,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: PRIMARY_COLOR,
                      width: 2.0,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 11,
                    horizontal: 8,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Container(
              width: 8,
              height: 2,
              color: SECONDARY_COLOR,
            ),
            SizedBox(width: 12),
            SizedBox(
              width: 97,
              height: 50,
              child: TextField(
                controller: _endNumberController,
                focusNode: _endFocusNode,
                style: TextStyle(
                  color: Colors.white,
                ),
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "5678",
                  hintStyle: TextStyle(color: TERITARY_COLOR),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: SECONDARY_COLOR,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: PRIMARY_COLOR,
                      width: 2.0,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 11,
                    horizontal: 8,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
