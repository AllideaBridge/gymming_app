import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../common/colors.dart';

class TextDropdown extends StatefulWidget {
  //상단의 제목
  final String? title;

  //플레이스홀더
  final String placeholder;

  //필수값 표시 여부
  final bool isRequired;

  //드롭다운 목록
  final List<String> dropdownItems;

  //선택된 값 부모 컴포넌트에 저장하는 메소드
  final Function setter;

  const TextDropdown({
    super.key,
    this.title,
    this.placeholder = '선택하세요',
    this.isRequired = false,
    required this.dropdownItems,
    required this.setter,
  });

  @override
  State<TextDropdown> createState() => _TextDropdownState();
}

class _TextDropdownState extends State<TextDropdown> {
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (widget.title != null)
        inputFieldTitle(widget.title!, widget.isRequired),
      DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text(
            widget.placeholder,
            style: TextStyle(
              fontSize: 16,
              color: TERITARY_COLOR,
            ),
          ),
          items: widget.dropdownItems
              .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ))
              .toList(),
          value: _selectedItem,
          onChanged: (String? value) {
            setState(() {
              _selectedItem = value;
              widget.setter(_selectedItem);
            });
          },
          buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: SECONDARY_COLOR, width: 2)),
              )),
          dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(width: 2, color: PRIMARY_COLOR),
            borderRadius: BorderRadius.circular(12),
          )),
          iconStyleData: const IconStyleData(
              icon: Icon(Icons.keyboard_arrow_up_rounded), iconSize: 12),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
        ),
      )
    ]);
  }

  Widget inputFieldTitle(String title, bool required) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              required ? '*' : '',
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
    );
  }
}
